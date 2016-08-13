@SitesShowBox = React.createClass
  getInitialState: ->
    site: @props.site
    country: @props.country
    volunteers: @props.volunteers
    contributors: @props.contributors 
    alertVisible: false

  handleAlertShow: ->
    @setState({ alertVisible: true })
  handleAlertDismiss: ->
    @setState({ alertVisible: false })

  render: ->
 
   alert =
      if @state.alertVisible
        `<Alert bsStyle='danger' onDismiss={this.handleAlertDismiss}>
          <h4>Something's wrong. Please check if you have entered the username correctly</h4>
        </Alert>`

    `<div>
      <header className="app-bar promote-layer">
        <div className="app-bar-container">
          <button className="menu"><span className="icon-menu"></span></button>
          <div className="Heading">
            <a href="/sites" className="Back"><span className="icon-chevron-left-thin"></span><span className="Back-text">Back</span></a>
            <h1 className="title"><span>Post</span></h1>
          </div>
        </div>
      </header>
      <main>
        <div className="SitesShowBox">
          <h2>{this.state.site.name} <span className="h4">{this.state.country.name}</span></h2>
          <br/>
                      
          {alert}
          <VolunteersList data={this.state.volunteers}/>
          <ContributorsList data={this.state.contributors}/>
        </div>
       </main>
     </div>`

@VolunteersList = React.createClass
 render: ->
    userNodes = @props.data.map((user) ->
      `<ShowUserNode key={user.id} user={user}/>`)
    `<div className="VolunteersList">
      <h3>Volunteers</h3>
     
      <ul>
        {userNodes}
      </ul>
    </div>`

@ContributorsList = React.createClass

  render: ->
    userNodes = @props.data.map((user) ->
      `<ShowUserNode key={user.id} user={user}/>`)
    `<div className="ContributorsList">
      <h3>Contributors</h3>
      <ul>
        {userNodes}
      </ul>
    </div>`

@ShowUserNode = React.createClass
 render: ->
    show_url = "/members/" + @props.user.id
    `<li type = "square" className="UserNode">
        <a className="h4" href={show_url}>{this.props.user.username} </a>
       <br/><br/>
    </li>`


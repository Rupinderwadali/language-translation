var Assign = React.createClass({
  propTypes: {
    site: React.PropTypes.string,
    country: React.PropTypes.string,
    volunteers: React.PropTypes.string,
    contributors: React.PropTypes.string,
    admins: React.PropTypes.string
  },

  render: function() {
    return (
      <div>
        <div>Site: {this.props.site}</div>
        <div>Country: {this.props.country}</div>
        <div>Volunteers: {this.props.volunteers}</div>
        <div>Contributors: {this.props.contributors}</div>
        <div>Admins: {this.props.admins}</div>
      </div>
    );
  }
});

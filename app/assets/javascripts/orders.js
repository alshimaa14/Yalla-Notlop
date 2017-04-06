// $(function() {
// 	$("#inviteFriends").on('click', function(e) {
// 		e.preventDefault();
// 		var checked_friends = $("input[name='invited_friends[]']:checked");
// 		var invited_friends_ids = [];
// 		checked_friends.each(function(){
// 			invited_friends_ids.push($(this).val());
// 			$.ajax({
// 			    type: 'POST',
// 			    url: 'https://serene-temple-30674.herokuapp.com/order_friend_invitations/',
// 			    data: { 
// 			        'user_id': $(this).val(), 
// 			        'ca$libri': 'no$libri'
// 			    },
// 			    success: function(msg){
// 			        alert('wow' + msg);
// 			    }
// 			});
// 		});

// 		console.log(invited_friends_ids);

// 		alert(invited_friends_ids);
// 	});

// });
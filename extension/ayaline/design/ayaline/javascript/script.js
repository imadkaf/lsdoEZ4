					function showHideSelect(select)
					{
					    var objSelect = document.getElementById(select);
					    objSelect.style.display = (objSelect.style.display == 'block') ? 'none' : 'block';
					}
					function validAndHide(txt, obj, input, select)
					{
					    document.getElementsByName(input).value = txt;
					    obj.parentNode.parentNode.style.display = 'none';
					    document.getElementById(select).innerHTML = obj.innerHTML;
					}
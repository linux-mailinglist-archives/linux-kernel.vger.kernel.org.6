Return-Path: <linux-kernel+bounces-183844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7567E8C9ED0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 16:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B83C2842E4
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 14:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F84C7C0B2;
	Mon, 20 May 2024 14:33:02 +0000 (UTC)
Received: from smtp153-168.sina.com.cn (smtp153-168.sina.com.cn [61.135.153.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6364182DF
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 14:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.135.153.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716215581; cv=none; b=fvnzyn9siK0X2CxfR+CeqiO1phCTqedIdUrTQcZB8blV3OcbD5Oh/ZeX36SZHeoqbKukDFYvOdFsW241fOIT0pRBPnw53CHQ6bg5MqE44m7ISJKfZXpeEMbtA7IfR0QZTkGZ7wPzReBmcYfBxne3F30XkkP88OHAskzUYXwJ5jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716215581; c=relaxed/simple;
	bh=RjA9QK1StFOq1s9zLGgz16s6I7u52YYHAsn2RqqMx/s=;
	h=Date:From:To:Cc:Subject:References:Mime-Version:Message-ID:
	 Content-Type; b=rpf22+RCrEyKqqGgazikl2if9o6huxva38zq/O6c5CniJ8/uL1pLduWVPmX9iBTzkrAmlfpB3sXNa+3o/db87ujRTnUU9JQZUKcDonVVENBCeSmp91qRCZvd2kM0w0Y5YrBfmhJENYfE/y/5XaEFuOY8ivjOd5wwFfE1ACg5r+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=61.135.153.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: PC-20220305VLFP
Received: from unknown (HELO PC-20220305VLFP)([112.97.60.228])
	by sina.com (10.182.253.23) with ESMTP
	id 664B5F0C00007E12; Mon, 20 May 2024 22:32:46 +0800 (CST)
X-Sender: nanfengwq@sina.com
X-Auth-ID: nanfengwq@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=nanfengwq@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=nanfengwq@sina.com
X-SMAIL-MID: 3256017864831
X-SMAIL-UIID: F46B7554566F41A4852BB1452072EFE2-20240520-223246-1
Date: Mon, 20 May 2024 22:32:21 +0800
From: "nanfengwq@sina.com" <nanfengwq@sina.com>
To: gregkh <gregkh@linuxfoundation.org>
Cc: balbi <balbi@kernel.org>, 
	linux-usb <linux-usb@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: memory leakage in ncm_wrap_ntb() in USB ncm mode with kernel 5.15
References: <2024051922230825069112@sina.com>, 
	<2024051901-gimmick-cosponsor-f2dd@gregkh>
X-Priority: 3
X-Has-Attach: yes
X-Mailer: Foxmail 7.2.25.254[cn]
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <202405202232198531894@sina.com>
Content-Type: multipart/mixed;
	boundary="----=_001_NextPart642033051568_=----"

This is a multi-part message in MIME format.

------=_001_NextPart642033051568_=----
Content-Type: multipart/alternative;
	boundary="----=_002_NextPart608575887075_=----"


------=_002_NextPart608575887075_=----
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64

aGVsbG86DQogICAgICAgSW4gZW1iZWRkZWQgZGV2aWNlcyB3aXRoIHJlbGF0aXZlbHkgc21hbGwg
bWVtb3J5LCBpZiB0aGUgdHJhbnNmZXIgc3BlZWQgb2YgbmNtIGlzIGZhc3QgYW5kIG90aGVyIHBy
b2dyYW1zIG9jY3VweSBDUFUgbWVtb3J5LCBpdCBpcyBsaWtlbHkgdGhhdCB0aGUgcmV0dXJuIHZh
bHVlIG5jbSAtPnNrZF90eF9kYXRhIG9mIGFsbG9jX3NrYigpIGlzIE5VTEwsIGFuZCB0aGUgY29k
ZSBpcyBsaWtlbHkgdG8gZW50ZXIgZXJyLiBJZiBza2IyIGlzIG5vdCBwcm9jZXNzZWQgaW4gZXJy
LCBpdCB3aWxsIGNhdXNlIG1lbW9yeSBsZWFrYWdlLg0KDQpUaGFuayB5b3UuDQoNCg0KbmFuZmVu
Z3dxQHNpbmEuY29tDQogDQpGcm9tOiBncmVna2gNCkRhdGU6IDIwMjQtMDUtMTkgMjI6MzcNClRv
OiBuYW5mZW5nd3FAc2luYS5jb20NCkNDOiBiYWxiaTsgbGludXgtdXNiOyBsaW51eC1rZXJuZWwN
ClN1YmplY3Q6IFJlOiBtZW1vcnkgbGVha2FnZSBpbiBuY21fd3JhcF9udGIoKSBpbiBVU0IgbmNt
IG1vZGUgd2l0aCBrZXJuZWwgNS4xNQ0KT24gU3VuLCBNYXkgMTksIDIwMjQgYXQgMTA6MjM6MTBQ
TSArMDgwMCwgbmFuZmVuZ3dxQHNpbmEuY29tIHdyb3RlOg0KPiBIZWxsb++8mg0KPiBJIGhhdmUg
ZGlzY292ZXJlZCBhIHJpc2sgb2YgbWVtb3J5IGxlYWthZ2UgaW4gbmNtX3dyYXBfbnRiKCkgdW5k
ZXIgVVNCIG5jbSBtb2RlIGluIGtlcm5lbCA1LjE1LCBhbmQgSSBoYXZlIGZpeGVkIGl0LiANCj4g
UGxlYXNlIGhlbHAgbWUgcmV2aWV3IGl0Lg0KPiANCj4gSWYgdGhpcyBtb2RpZmljYXRpb24gaXMg
ZWZmZWN0aXZlLCBpdCBjYW4gYWxzbyBiZSBpbnRlZ3JhdGVkIGludG8gb3RoZXIga2VybmVsIHZl
cnNpb25zLCBzdWNoIGFzIGtlcm5lbCA0LjE0LCBhbmQgc28gb24uDQo+IA0KPiBUaGUgbG9naWMg
b2YgYSBtZW1vcnkgbGVhayBpcyBhcyBmb2xsb3dzOg0KPiANCj4gSWYgdGhlIHJldHVybiB2YWx1
ZSBza2IyIG9mICBwYWNrYWdlX2Zvcl90eCgpIGlzIG5vdCBOVUxMLCBhbmQgdGhlIHJldHVybiB2
YWx1ZSBuY20tPnNrYl90eF9kYXRhIG9mIGFsbG9jX3NrYigpIGlzIE5VTEwsIHRoZW4gdGhlIGNv
ZGUgd2lsbCBnbyB0byBlcnIsIHdoZXJlIHRoZXJlIGlzIG5vIHByb2Nlc3Npbmcgb2Ygc2tiMiwg
cmVzdWx0aW5nIGluIGEgbWVtb3J5IGxlYWsgaW4gc2tiMi4NCj4gDQo+IA0KPiBUaGFuayB5b3Uu
DQo+IA0KPiANCj4gDQo+IA0KIA0KIA0KSGksDQogDQpUaGlzIGlzIHRoZSBmcmllbmRseSBwYXRj
aC1ib3Qgb2YgR3JlZyBLcm9haC1IYXJ0bWFuLiAgWW91IGhhdmUgc2VudCBoaW0NCmEgcGF0Y2gg
dGhhdCBoYXMgdHJpZ2dlcmVkIHRoaXMgcmVzcG9uc2UuICBIZSB1c2VkIHRvIG1hbnVhbGx5IHJl
c3BvbmQNCnRvIHRoZXNlIGNvbW1vbiBwcm9ibGVtcywgYnV0IGluIG9yZGVyIHRvIHNhdmUgaGlz
IHNhbml0eSAoaGUga2VwdA0Kd3JpdGluZyB0aGUgc2FtZSB0aGluZyBvdmVyIGFuZCBvdmVyLCB5
ZXQgdG8gZGlmZmVyZW50IHBlb3BsZSksIEkgd2FzDQpjcmVhdGVkLiAgSG9wZWZ1bGx5IHlvdSB3
aWxsIG5vdCB0YWtlIG9mZmVuY2UgYW5kIHdpbGwgZml4IHRoZSBwcm9ibGVtDQppbiB5b3VyIHBh
dGNoIGFuZCByZXN1Ym1pdCBpdCBzbyB0aGF0IGl0IGNhbiBiZSBhY2NlcHRlZCBpbnRvIHRoZSBM
aW51eA0Ka2VybmVsIHRyZWUuDQogDQpZb3UgYXJlIHJlY2VpdmluZyB0aGlzIG1lc3NhZ2UgYmVj
YXVzZSBvZiB0aGUgZm9sbG93aW5nIGNvbW1vbiBlcnJvcihzKQ0KYXMgaW5kaWNhdGVkIGJlbG93
Og0KIA0KLSBZb3VyIHBhdGNoIGRpZCBub3QgYXBwbHkgdG8gYW55IGtub3duIHRyZWVzIHRoYXQg
R3JlZyBpcyBpbiBjb250cm9sDQogIG9mLiAgUG9zc2libHkgdGhpcyBpcyBiZWNhdXNlIHlvdSBt
YWRlIGl0IGFnYWluc3QgTGludXMncyB0cmVlLCBub3QNCiAgdGhlIGxpbnV4LW5leHQgdHJlZSwg
d2hpY2ggaXMgd2hlcmUgYWxsIG9mIHRoZSBkZXZlbG9wbWVudCBmb3IgdGhlDQogIG5leHQgdmVy
c2lvbiBvZiB0aGUga2VybmVsIGlzIGF0LiAgUGxlYXNlIHJlZnJlc2ggeW91ciBwYXRjaCBhZ2Fp
bnN0DQogIHRoZSBsaW51eC1uZXh0IHRyZWUsIG9yIGV2ZW4gYmV0dGVyIHlldCwgdGhlIGRldmVs
b3BtZW50IHRyZWUNCiAgc3BlY2lmaWVkIGluIHRoZSBNQUlOVEFJTkVSUyBmaWxlIGZvciB0aGUg
c3Vic3lzdGVtIHlvdSBhcmUgc3VibWl0dGluZw0KICBhIHBhdGNoIGZvciwgYW5kIHJlc2VuZCBp
dC4NCiANCi0gWW91IGRpZCBub3Qgc3BlY2lmeSBhIGRlc2NyaXB0aW9uIG9mIHdoeSB0aGUgcGF0
Y2ggaXMgbmVlZGVkLCBvcg0KICBwb3NzaWJseSwgYW55IGRlc2NyaXB0aW9uIGF0IGFsbCwgaW4g
dGhlIGVtYWlsIGJvZHkuICBQbGVhc2UgcmVhZCB0aGUNCiAgc2VjdGlvbiBlbnRpdGxlZCAiVGhl
IGNhbm9uaWNhbCBwYXRjaCBmb3JtYXQiIGluIHRoZSBrZXJuZWwgZmlsZSwNCiAgRG9jdW1lbnRh
dGlvbi9wcm9jZXNzL3N1Ym1pdHRpbmctcGF0Y2hlcy5yc3QgZm9yIHdoYXQgaXMgbmVlZGVkIGlu
DQogIG9yZGVyIHRvIHByb3Blcmx5IGRlc2NyaWJlIHRoZSBjaGFuZ2UuDQogDQotIFlvdSBkaWQg
bm90IHdyaXRlIGEgZGVzY3JpcHRpdmUgU3ViamVjdDogZm9yIHRoZSBwYXRjaCwgYWxsb3dpbmcg
R3JlZywNCiAgYW5kIGV2ZXJ5b25lIGVsc2UsIHRvIGtub3cgd2hhdCB0aGlzIHBhdGNoIGlzIGFs
bCBhYm91dC4gIFBsZWFzZSByZWFkDQogIHRoZSBzZWN0aW9uIGVudGl0bGVkICJUaGUgY2Fub25p
Y2FsIHBhdGNoIGZvcm1hdCIgaW4gdGhlIGtlcm5lbCBmaWxlLA0KICBEb2N1bWVudGF0aW9uL3By
b2Nlc3Mvc3VibWl0dGluZy1wYXRjaGVzLnJzdCBmb3Igd2hhdCBhIHByb3Blcg0KICBTdWJqZWN0
OiBsaW5lIHNob3VsZCBsb29rIGxpa2UuDQogDQotIEl0IGxvb2tzIGxpa2UgeW91IGRpZCBub3Qg
dXNlIHlvdXIgInJlYWwiIG5hbWUgZm9yIHRoZSBwYXRjaCBvbiBlaXRoZXINCiAgdGhlIFNpZ25l
ZC1vZmYtYnk6IGxpbmUsIG9yIHRoZSBGcm9tOiBsaW5lIChib3RoIG9mIHdoaWNoIGhhdmUgdG8N
CiAgbWF0Y2gpLiAgUGxlYXNlIHJlYWQgdGhlIGtlcm5lbCBmaWxlLA0KICBEb2N1bWVudGF0aW9u
L3Byb2Nlc3Mvc3VibWl0dGluZy1wYXRjaGVzLnJzdCBmb3IgaG93IHRvIGRvIHRoaXMNCiAgY29y
cmVjdGx5Lg0KIA0KSWYgeW91IHdpc2ggdG8gZGlzY3VzcyB0aGlzIHByb2JsZW0gZnVydGhlciwg
b3IgeW91IGhhdmUgcXVlc3Rpb25zIGFib3V0DQpob3cgdG8gcmVzb2x2ZSB0aGlzIGlzc3VlLCBw
bGVhc2UgZmVlbCBmcmVlIHRvIHJlc3BvbmQgdG8gdGhpcyBlbWFpbCBhbmQNCkdyZWcgd2lsbCBy
ZXBseSBvbmNlIGhlIGhhcyBkdWcgb3V0IGZyb20gdGhlIHBlbmRpbmcgcGF0Y2hlcyByZWNlaXZl
ZA0KZnJvbSBvdGhlciBkZXZlbG9wZXJzLg0KIA0KdGhhbmtzLA0KIA0KZ3JlZyBrLWgncyBwYXRj
aCBlbWFpbCBib3QNCiANCg==

------=_002_NextPart608575887075_=----
Content-Type: text/html;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<html><head><meta http-equiv=3D"content-type" content=3D"text/html; charse=
t=3DUTF-8"><style>body { line-height: 1.5; }blockquote { margin-top: 0px; =
margin-bottom: 0px; margin-left: 0.5em; }body { font-size: 14px; font-fami=
ly: "Microsoft YaHei UI"; color: rgb(0, 0, 0); line-height: 1.5; }</style>=
</head><body>=0A<div>hello:</div><div><span></span><span style=3D"backgrou=
nd-color: transparent;">&nbsp; &nbsp;&nbsp;</span><span style=3D"backgroun=
d-color: transparent;">&nbsp; &nbsp;</span><span style=3D"background-color=
: transparent;">In embedded devices with relatively small memory, if the t=
ransfer speed of ncm is fast and other programs occupy CPU memory, it is l=
ikely that the return value ncm -&gt;skd_tx_data of alloc_skb() is NULL, a=
nd the code is likely to enter err. If skb2 is not processed in err, it wi=
ll cause memory leakage.</span></div>=0A<div><br></div><div>Thank you.</di=
v><hr style=3D"width: 210px; height: 1px;" color=3D"#b5c4df" size=3D"1" al=
ign=3D"left">=0A<div><span><div style=3D"MARGIN: 10px; FONT-FAMILY: verdan=
a; FONT-SIZE: 10pt"><div>nanfengwq@sina.com</div></div></span></div>=0A<bl=
ockquote style=3D"margin-Top: 0px; margin-Bottom: 0px; margin-Left: 0.5em;=
 margin-Right: inherit"><div>&nbsp;</div><div style=3D"border:none;border-=
top:solid #B5C4DF 1.0pt;padding:3.0pt 0cm 0cm 0cm"><div style=3D"PADDING-R=
IGHT: 8px; PADDING-LEFT: 8px; FONT-SIZE: 12px;FONT-FAMILY:tahoma;COLOR:#00=
0000; BACKGROUND: #efefef; PADDING-BOTTOM: 8px; PADDING-TOP: 8px"><div><b>=
From:</b>&nbsp;<a href=3D"mailto:gregkh@linuxfoundation.org">gregkh</a></d=
iv><div><b>Date:</b>&nbsp;2024-05-19&nbsp;22:37</div><div><b>To:</b>&nbsp;=
<a href=3D"mailto:nanfengwq@sina.com">nanfengwq@sina.com</a></div><div><b>=
CC:</b>&nbsp;<a href=3D"mailto:balbi@kernel.org">balbi</a>; <a href=3D"mai=
lto:linux-usb@vger.kernel.org">linux-usb</a>; <a href=3D"mailto:linux-kern=
el@vger.kernel.org">linux-kernel</a></div><div><b>Subject:</b>&nbsp;Re: me=
mory leakage in ncm_wrap_ntb() in USB ncm mode with kernel 5.15</div></div=
></div><div><div>On Sun, May 19, 2024 at 10:23:10PM +0800, nanfengwq@sina.=
com wrote:</div>=0A<div>&gt; Hello=EF=BC=9A</div>=0A<div>&gt; I have disco=
vered a risk of memory leakage in ncm_wrap_ntb() under USB ncm mode in ker=
nel 5.15, and I have fixed it. </div>=0A<div>&gt; Please help me review it=
</div>=0A<div>&gt; </div>=0A<div>&gt; If this modification is effective, =
it can also be integrated into other kernel versions, such as kernel 4.14,=
 and so on.</div>=0A<div>&gt; </div>=0A<div>&gt; The logic of a memory lea=
k is as follows:</div>=0A<div>&gt; </div>=0A<div>&gt; If the return value =
skb2 of&nbsp; package_for_tx() is not NULL, and the return value ncm-&gt;s=
kb_tx_data of alloc_skb() is NULL, then the code will go to err, where the=
re is no processing of skb2, resulting in a memory leak in skb2.</div>=0A<=
div>&gt; </div>=0A<div>&gt; </div>=0A<div>&gt; Thank you.</div>=0A<div>&gt=
; </div>=0A<div>&gt; </div>=0A<div>&gt; </div>=0A<div>&gt; </div>=0A<div>&=
nbsp;</div>=0A<div>&nbsp;</div>=0A<div>Hi,</div>=0A<div>&nbsp;</div>=0A<di=
v>This is the friendly patch-bot of Greg Kroah-Hartman.&nbsp; You have sen=
t him</div>=0A<div>a patch that has triggered this response.&nbsp; He used=
 to manually respond</div>=0A<div>to these common problems, but in order t=
o save his sanity (he kept</div>=0A<div>writing the same thing over and ov=
er, yet to different people), I was</div>=0A<div>created.&nbsp; Hopefully =
you will not take offence and will fix the problem</div>=0A<div>in your pa=
tch and resubmit it so that it can be accepted into the Linux</div>=0A<div=
>kernel tree.</div>=0A<div>&nbsp;</div>=0A<div>You are receiving this mess=
age because of the following common error(s)</div>=0A<div>as indicated bel=
ow:</div>=0A<div>&nbsp;</div>=0A<div>- Your patch did not apply to any kno=
wn trees that Greg is in control</div>=0A<div>&nbsp; of.&nbsp; Possibly th=
is is because you made it against Linus's tree, not</div>=0A<div>&nbsp; th=
e linux-next tree, which is where all of the development for the</div>=0A<=
div>&nbsp; next version of the kernel is at.&nbsp; Please refresh your pat=
ch against</div>=0A<div>&nbsp; the linux-next tree, or even better yet, th=
e development tree</div>=0A<div>&nbsp; specified in the MAINTAINERS file f=
or the subsystem you are submitting</div>=0A<div>&nbsp; a patch for, and r=
esend it.</div>=0A<div>&nbsp;</div>=0A<div>- You did not specify a descrip=
tion of why the patch is needed, or</div>=0A<div>&nbsp; possibly, any desc=
ription at all, in the email body.&nbsp; Please read the</div>=0A<div>&nbs=
p; section entitled "The canonical patch format" in the kernel file,</div>=
=0A<div>&nbsp; Documentation/process/submitting-patches.rst for what is ne=
eded in</div>=0A<div>&nbsp; order to properly describe the change.</div>=
=0A<div>&nbsp;</div>=0A<div>- You did not write a descriptive Subject: for=
 the patch, allowing Greg,</div>=0A<div>&nbsp; and everyone else, to know =
what this patch is all about.&nbsp; Please read</div>=0A<div>&nbsp; the se=
ction entitled "The canonical patch format" in the kernel file,</div>=0A<d=
iv>&nbsp; Documentation/process/submitting-patches.rst for what a proper</=
div>=0A<div>&nbsp; Subject: line should look like.</div>=0A<div>&nbsp;</di=
v>=0A<div>- It looks like you did not use your "real" name for the patch o=
n either</div>=0A<div>&nbsp; the Signed-off-by: line, or the From: line (b=
oth of which have to</div>=0A<div>&nbsp; match).&nbsp; Please read the ker=
nel file,</div>=0A<div>&nbsp; Documentation/process/submitting-patches.rst=
 for how to do this</div>=0A<div>&nbsp; correctly.</div>=0A<div>&nbsp;</di=
v>=0A<div>If you wish to discuss this problem further, or you have questio=
ns about</div>=0A<div>how to resolve this issue, please feel free to respo=
nd to this email and</div>=0A<div>Greg will reply once he has dug out from=
 the pending patches received</div>=0A<div>from other developers.</div>=0A=
<div>&nbsp;</div>=0A<div>thanks,</div>=0A<div>&nbsp;</div>=0A<div>greg k-h=
's patch email bot</div>=0A<div>&nbsp;</div>=0A</div></blockquote>=0A</bod=
y></html>
------=_002_NextPart608575887075_=------

------=_001_NextPart642033051568_=----
Content-Type: application/octet-stream;
	name="0001-USB-NCM-mode-There-is-a-memory-leak.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="0001-USB-NCM-mode-There-is-a-memory-leak.patch"

RnJvbSAyOWQ0NTBiMzI3OGQ1MDkwZDhiNjJmNzg0ZTk5M2IwZWIxMWVlYzM0IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBuYW5mZW5nd3EgPG5hbmZlbmd3cUBzaW5hLmNvbT4KRGF0ZTog
U2F0LCAxOCBNYXkgMjAyNCAxNjoxNTo0NSArMDgwMApTdWJqZWN0OiBbUEFUQ0hdIFVTQihOQ00g
bW9kZSk6VGhlcmUgaXMgYSBtZW1vcnkgbGVhawoKSWYgc2tiMiBpcyBub3QgZXF1YWwgdG8gTlVM
TCBhbmQgdGhlIHJldHVybiB2YWx1ZSBvZiBhbGxvY3NrYigpIGlzIE5VTEwsaXQgd2lsbCBjYXVz
ZSBhIG1lbW9yeSBsZWFrCgpTaWduZWQtb2ZmLWJ5OiBuYW5mZW5nd3EgPG5hbmZlbmd3cUBzaW5h
LmNvbT4KLS0tCiBkcml2ZXJzL3VzYi9nYWRnZXQvZnVuY3Rpb24vZl9uY20uYyB8IDIgKy0KIDEg
ZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBh
L2RyaXZlcnMvdXNiL2dhZGdldC9mdW5jdGlvbi9mX25jbS5jIGIvZHJpdmVycy91c2IvZ2FkZ2V0
L2Z1bmN0aW9uL2ZfbmNtLmMKaW5kZXggZTBjMTgzMjM0Li5jOWJkZTdhZmQgMTAwNjQ0Ci0tLSBh
L2RyaXZlcnMvdXNiL2dhZGdldC9mdW5jdGlvbi9mX25jbS5jCisrKyBiL2RyaXZlcnMvdXNiL2dh
ZGdldC9mdW5jdGlvbi9mX25jbS5jCkBAIC0xMTQ0LDcgKzExNDQsNyBAQCBzdGF0aWMgc3RydWN0
IHNrX2J1ZmYgKm5jbV93cmFwX250YihzdHJ1Y3QgZ2V0aGVyICpwb3J0LAogCWlmIChuY20tPnNr
Yl90eF9uZHApCiAJCWRldl9rZnJlZV9za2JfYW55KG5jbS0+c2tiX3R4X25kcCk7CiAKLQlyZXR1
cm4gTlVMTDsKKwlyZXR1cm4gc2tiMjsKIH0KIAogLyoKLS0gCjIuMzIuMC53aW5kb3dzLjEKCg==

------=_001_NextPart642033051568_=------



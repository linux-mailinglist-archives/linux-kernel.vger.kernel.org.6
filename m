Return-Path: <linux-kernel+bounces-214482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D1E908557
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 09:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A2EB1C21665
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 07:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E2E6183071;
	Fri, 14 Jun 2024 07:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lixiang-com.20200927.dkim.feishu.cn header.i=@lixiang-com.20200927.dkim.feishu.cn header.b="P9AOE3uP"
Received: from va-1-13.ptr.blmpb.com (va-1-13.ptr.blmpb.com [209.127.230.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE2A157E7D
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 07:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718351569; cv=none; b=A/aTPOteWxUqJ0NSCj4CiRuWm2LC240ZTzj/SAN/+45/toZpysDJwYi8KKl7PB+7l4R6mFaHX7v2b6t8/zuGMQNMnIyfcEbG3ZPGu6xPLR/u+MTHqpUUTFJOyg+0bEttumFBWwR+AIZcx7fz5EpaQMJQXtuNffXD6jPxaUB79Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718351569; c=relaxed/simple;
	bh=RJ6yoUuibA7QGbHV0hXqkWPqtcHSW7nWfBfUCjFYA34=;
	h=Content-Type:Date:Message-Id:To:Subject:From:Mime-Version; b=Rvy4Fs6KMkL7Lwl2ZeTz+O4OtVnvq1s0FInP3zXx0VsRg2aFzNEY8lM7kYrKprOaWCFdGR414oP1ZvkzYMf7j8K0uCQTh7b2wh9TSzOaevCM2k85GHFH27ky+f/TRfZaPY5hWYKGRHtinaeFQ3/JRLI+Iy9nUvxt9dybXkvbyN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lixiang.com; spf=pass smtp.mailfrom=lixiang.com; dkim=pass (2048-bit key) header.d=lixiang-com.20200927.dkim.feishu.cn header.i=@lixiang-com.20200927.dkim.feishu.cn header.b=P9AOE3uP; arc=none smtp.client-ip=209.127.230.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lixiang.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lixiang.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=lixiang-com.20200927.dkim.feishu.cn; t=1718351554;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=RJ6yoUuibA7QGbHV0hXqkWPqtcHSW7nWfBfUCjFYA34=;
 b=P9AOE3uPMbuJ/U4KLfYk4JOUIDhatVUhzdQ609AVZTDV+v7xX89gOr4ece1Z56vBN76RAh
 G7jrZQ3F+sPARIa4JtTSd9FN6iJL9ssOoqoVCq5IZPozaqTgaFIMS60LbeUANvlgYIyLzQ
 hrOTdBA4Zp44d87doZ7z16Y9hwgFxz7+vtBGxY949/nxH7bbVAypLOhVrmQyh5uyQiXL/y
 osSiDYRWM7HY0Uoxlh4Y9Pp+EA0snzJdla9Fsk8Z0VyZkOd1OIiD+PW6Uc39+Gk+chYNJ1
 a1sE6ukc7HjMk8jYX0ZIGiOmttMl1GAjwN2U7p8CTRp/S29efCZR8OvqY2JHuA==
X-Lms-Return-Path: <lba+1666bf6c1+8ef909+vger.kernel.org+shisiyuan@lixiang.com>
Content-Type: multipart/mixed;
 boundary=c61732073438e75300aa435d45534b538daa8b593736e711dc3a6d49ee40
Date: Fri, 14 Jun 2024 15:52:32 +0800
Message-Id: <7369acecbf91db58e8c539678867170b5eef13e3.f5a34363.12c5.4c20.b839.0ef7c6407444@feishu.cn>
To: "Andrew Morton" <akpm@linux-foundation.org>, 
	"linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: 0001-mm-rmap-Correct-stats-calulation-in-__folio_remove_r
From: =?utf-8?q?=E5=8F=B2=E6=80=9D=E8=BF=9C?= <shisiyuan@lixiang.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0

--c61732073438e75300aa435d45534b538daa8b593736e711dc3a6d49ee40
Content-Type: multipart/alternative;
 boundary=784af078e0a4c6ced8ad7a6c349662478a0acecac519abef303be6560fe0

--784af078e0a4c6ced8ad7a6c349662478a0acecac519abef303be6560fe0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Dear mm maintainers,

This patch fixes wrong stats calulation=C2=A0in __folio_remove_rmap().

diff --git a/mm/rmap.c b/mm/rmap.c
index 52357d79917c..f9aeabd691fa 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1567,7 +1567,7 @@ static __always_inline void __folio_remove_rmap(struc=
t folio *folio,
=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =
list_empty(&folio->_deferred_list))
=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0=C2=A0 deferred_split_folio(folio);
=C2=A0=C2=A0 =C2=A0 =C2=A0=C2=A0 }
- =C2=A0 =C2=A0 =C2=A0 __folio_mod_stat(folio, nr, nr_pmdmapped);
+ =C2=A0 =C2=A0 =C2=A0 __folio_mod_stat(folio, -nr, -nr_pmdmapped);
=C2=A0
=C2=A0=C2=A0 =C2=A0 =C2=A0=C2=A0 /*
=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 * It would be tidy to reset folio_test_an=
on mapping when fully

BRs,
Stephen

=E5=A3=B0=E6=98=8E=EF=BC=9A=E8=BF=99=E5=B0=81=E9=82=AE=E4=BB=B6=E5=8F=AA=E5=
=85=81=E8=AE=B8=E6=96=87=E4=BB=B6=E6=8E=A5=E6=94=B6=E8=80=85=E9=98=85=E8=AF=
=BB=EF=BC=8C=E6=9C=89=E5=BE=88=E9=AB=98=E7=9A=84=E6=9C=BA=E5=AF=86=E6=80=A7=
=E8=A6=81=E6=B1=82=E3=80=82=E7=A6=81=E6=AD=A2=E5=85=B6=E4=BB=96=E4=BA=BA=E4=
=BD=BF=E7=94=A8=E3=80=81=E6=89=93=E5=BC=80=E3=80=81=E5=A4=8D=E5=88=B6=E6=88=
=96=E8=BD=AC=E5=8F=91=E9=87=8C=E9=9D=A2=E7=9A=84=E4=BB=BB=E4=BD=95=E5=86=85=
=E5=AE=B9=E3=80=82=E5=A6=82=E6=9E=9C=E6=9C=AC=E9=82=AE=E4=BB=B6=E9=94=99=E8=
=AF=AF=E5=9C=B0=E5=8F=91=E7=BB=99=E4=BA=86=E4=BD=A0=EF=BC=8C=E8=AF=B7=E8=81=
=94=E7=B3=BB=E9=82=AE=E4=BB=B6=E5=8F=91=E5=87=BA=E8=80=85=E5=B9=B6=E5=88=A0=
=E9=99=A4=E8=BF=99=E4=B8=AA=E6=96=87=E4=BB=B6=E3=80=82=E6=9C=BA=E5=AF=86=E5=
=8F=8A=E6=B3=95=E5=BE=8B=E7=9A=84=E7=89=B9=E6=9D=83=E5=B9=B6=E4=B8=8D=E5=9B=
=A0=E4=B8=BA=E8=AF=AF=E5=8F=91=E9=82=AE=E4=BB=B6=E8=80=8C=E6=94=BE=E5=BC=83=
=E6=88=96=E4=B8=A7=E5=A4=B1=E3=80=82=E4=BB=BB=E4=BD=95=E6=8F=90=E5=87=BA=E7=
=9A=84=E8=A7=82=E7=82=B9=E6=88=96=E6=84=8F=E8=A7=81=E5=8F=AA=E5=B1=9E=E4=BA=
=8E=E4=BD=9C=E8=80=85=E7=9A=84=E4=B8=AA=E4=BA=BA=E8=A7=81=E8=A7=A3=EF=BC=8C=
=E5=B9=B6=E4=B8=8D=E4=B8=80=E5=AE=9A=E4=BB=A3=E8=A1=A8=E6=9C=AC=E5=85=AC=E5=
=8F=B8=E3=80=82
Disclaimer: This email is intended to be read only by the designated recipi=
ent of the document and has high confidentiality requirements. Anyone else =
is prohibited from using, opening, copying or forwarding any of the content=
s inside. If this email was sent to you by mistake, please contact the send=
er of the email and delete this file immediately. Confidentiality and legal=
 privileges are not waived or lost by misdirected emails. Any views or opin=
ions expressed in the email are those of the author and do not necessarily =
represent those of the Company.


--784af078e0a4c6ced8ad7a6c349662478a0acecac519abef303be6560fe0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html; charset=UTF-8

<div id=3D"editor_version_1.39.7_lwKa1jkJ" style=3D"word-break:break-word;"=
><div data-zone-id=3D"0" data-line-index=3D"0" data-line=3D"true" style=3D"=
margin-top: 4px; margin-bottom: 4px; line-height: 1.6;"><div style=3D"font-=
size: 14px;">Dear mm maintainers,</div></div><div data-zone-id=3D"0" data-l=
ine-index=3D"1" data-line=3D"true" style=3D"margin-top: 4px; margin-bottom:=
 4px; line-height: 1.6;"><div style=3D"font-size: 14px;"><br></div></div><d=
iv data-zone-id=3D"0" data-line-index=3D"2" data-line=3D"true" style=3D"mar=
gin-top: 4px; margin-bottom: 4px; line-height: 1.6;"><div style=3D"font-siz=
e: 14px;">This patch fixes wrong stats calulation&nbsp;in __folio_remove_rm=
ap().</div></div><div data-zone-id=3D"0" data-line-index=3D"3" data-line=3D=
"true" style=3D"margin-top: 4px; margin-bottom: 4px; line-height: 1.6;"><di=
v style=3D"font-size: 14px;"><br></div></div><div data-zone-id=3D"0" data-l=
ine-index=3D"4" data-line=3D"true" style=3D"margin-top: 4px; margin-bottom:=
 4px; line-height: 1.6;"><div style=3D"font-size: 14px;">diff --git a/mm/rm=
ap.c b/mm/rmap.c</div></div><div data-zone-id=3D"0" data-line-index=3D"5" d=
ata-line=3D"true" style=3D"margin-top: 4px; margin-bottom: 4px; line-height=
: 1.6;"><div style=3D"font-size: 14px;">index 52357d79917c..f9aeabd691fa 10=
0644</div></div><div data-zone-id=3D"0" data-line-index=3D"6" data-line=3D"=
true" style=3D"margin-top: 4px; margin-bottom: 4px; line-height: 1.6;"><div=
 style=3D"font-size: 14px;">--- a/mm/rmap.c</div></div><div data-zone-id=3D=
"0" data-line-index=3D"7" data-line=3D"true" style=3D"margin-top: 4px; marg=
in-bottom: 4px; line-height: 1.6;"><div style=3D"font-size: 14px;">+++ b/mm=
/rmap.c</div></div><div data-zone-id=3D"0" data-line-index=3D"8" data-line=
=3D"true" style=3D"margin-top: 4px; margin-bottom: 4px; line-height: 1.6;">=
<div style=3D"font-size: 14px;">@@ -1567,7 +1567,7 @@ static __always_inlin=
e void __folio_remove_rmap(struct folio *folio,</div></div><div data-zone-i=
d=3D"0" data-line-index=3D"9" data-line=3D"true" style=3D"margin-top: 4px; =
margin-bottom: 4px; line-height: 1.6;"><div style=3D"font-size: 14px;">&nbs=
p;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; list=
_empty(&amp;folio-&gt;_deferred_list))</div></div><div data-zone-id=3D"0" d=
ata-line-index=3D"10" data-line=3D"true" style=3D"margin-top: 4px; margin-b=
ottom: 4px; line-height: 1.6;"><div style=3D"font-size: 14px;">&nbsp;&nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp=
; deferred_split_folio(folio);</div></div><div data-zone-id=3D"0" data-line=
-index=3D"11" data-line=3D"true" style=3D"margin-top: 4px; margin-bottom: 4=
px; line-height: 1.6;"><div style=3D"font-size: 14px;">&nbsp;&nbsp; &nbsp; =
&nbsp;&nbsp; }</div></div><div data-zone-id=3D"0" data-line-index=3D"12" da=
ta-line=3D"true" style=3D"margin-top: 4px; margin-bottom: 4px; line-height:=
 1.6;"><div style=3D"font-size: 14px;">- &nbsp; &nbsp; &nbsp; __folio_mod_s=
tat(folio, nr, nr_pmdmapped);</div></div><div data-zone-id=3D"0" data-line-=
index=3D"13" data-line=3D"true" style=3D"margin-top: 4px; margin-bottom: 4p=
x; line-height: 1.6;"><div style=3D"font-size: 14px;">+ &nbsp; &nbsp; &nbsp=
; __folio_mod_stat(folio, -nr, -nr_pmdmapped);</div></div><div data-zone-id=
=3D"0" data-line-index=3D"14" data-line=3D"true" style=3D"margin-top: 4px; =
margin-bottom: 4px; line-height: 1.6;"><div style=3D"font-size: 14px;"><spa=
n>&nbsp;
</span></div></div><div data-zone-id=3D"0" data-line-index=3D"15" data-line=
=3D"true" style=3D"margin-top: 4px; margin-bottom: 4px; line-height: 1.6;">=
<div style=3D"font-size: 14px;">&nbsp;&nbsp; &nbsp; &nbsp;&nbsp; /*</div></=
div><div data-zone-id=3D"0" data-line-index=3D"16" data-line=3D"true" style=
=3D"margin-top: 4px; margin-bottom: 4px; line-height: 1.6;"><div style=3D"f=
ont-size: 14px;">&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; * It would be tidy to re=
set folio_test_anon mapping when fully</div></div><div data-zone-id=3D"0" d=
ata-line-index=3D"17" data-line=3D"true" style=3D"margin-top: 4px; margin-b=
ottom: 4px; line-height: 1.6;"><div style=3D"font-size: 14px;"><br></div></=
div><div data-zone-id=3D"0" data-line-index=3D"18" data-line=3D"true" style=
=3D"margin-top: 4px; margin-bottom: 4px; line-height: 1.6;"><div style=3D"f=
ont-size: 14px;">BRs,</div></div><div data-zone-id=3D"0" data-line-index=3D=
"19" data-line=3D"true" style=3D"margin-top: 4px; margin-bottom: 4px; line-=
height: 1.6;"><div style=3D"font-size: 14px;">Stephen</div></div></div><met=
a data-version=3D"editor_version_1.2.12"/><div data-zone-id=3D"0" data-line=
-index=3D"0" data-line=3D"true" style=3D"white-space: pre-wrap; margin-top:=
 4px; margin-bottom: 4px; line-height: 1.6;"><br></div><div data-zone-id=3D=
"0" data-line-index=3D"1" data-line=3D"true" style=3D"white-space: pre-wrap=
; margin-top: 4px; margin-bottom: 4px; line-height: 1.6;"><div style=3D"tex=
t-align: left;"><span style=3D"font-size: 12px;"><span style=3D"font-family=
: helvetica;"><span style=3D"color: rgb(143, 149, 158);">=E5=A3=B0=E6=98=8E=
=EF=BC=9A=E8=BF=99=E5=B0=81=E9=82=AE=E4=BB=B6=E5=8F=AA=E5=85=81=E8=AE=B8=E6=
=96=87=E4=BB=B6=E6=8E=A5=E6=94=B6=E8=80=85=E9=98=85=E8=AF=BB=EF=BC=8C=E6=9C=
=89=E5=BE=88=E9=AB=98=E7=9A=84=E6=9C=BA=E5=AF=86=E6=80=A7=E8=A6=81=E6=B1=82=
=E3=80=82=E7=A6=81=E6=AD=A2=E5=85=B6=E4=BB=96=E4=BA=BA=E4=BD=BF=E7=94=A8=E3=
=80=81=E6=89=93=E5=BC=80=E3=80=81=E5=A4=8D=E5=88=B6=E6=88=96=E8=BD=AC=E5=8F=
=91=E9=87=8C=E9=9D=A2=E7=9A=84=E4=BB=BB=E4=BD=95=E5=86=85=E5=AE=B9=E3=80=82=
=E5=A6=82=E6=9E=9C=E6=9C=AC=E9=82=AE=E4=BB=B6=E9=94=99=E8=AF=AF=E5=9C=B0=E5=
=8F=91=E7=BB=99=E4=BA=86=E4=BD=A0=EF=BC=8C=E8=AF=B7=E8=81=94=E7=B3=BB=E9=82=
=AE=E4=BB=B6=E5=8F=91=E5=87=BA=E8=80=85=E5=B9=B6=E5=88=A0=E9=99=A4=E8=BF=99=
=E4=B8=AA=E6=96=87=E4=BB=B6=E3=80=82=E6=9C=BA=E5=AF=86=E5=8F=8A=E6=B3=95=E5=
=BE=8B=E7=9A=84=E7=89=B9=E6=9D=83=E5=B9=B6=E4=B8=8D=E5=9B=A0=E4=B8=BA=E8=AF=
=AF=E5=8F=91=E9=82=AE=E4=BB=B6=E8=80=8C=E6=94=BE=E5=BC=83=E6=88=96=E4=B8=A7=
=E5=A4=B1=E3=80=82=E4=BB=BB=E4=BD=95=E6=8F=90=E5=87=BA=E7=9A=84=E8=A7=82=E7=
=82=B9=E6=88=96=E6=84=8F=E8=A7=81=E5=8F=AA=E5=B1=9E=E4=BA=8E=E4=BD=9C=E8=80=
=85=E7=9A=84=E4=B8=AA=E4=BA=BA=E8=A7=81=E8=A7=A3=EF=BC=8C=E5=B9=B6=E4=B8=8D=
=E4=B8=80=E5=AE=9A=E4=BB=A3=E8=A1=A8=E6=9C=AC=E5=85=AC=E5=8F=B8=E3=80=82
</span></span></span></div></div><div data-zone-id=3D"0" data-line-index=3D=
"2" data-line=3D"true" style=3D"white-space: pre-wrap; margin-top: 4px; mar=
gin-bottom: 4px; line-height: 1.6;"><div style=3D"text-align: left;"><span =
style=3D"font-size: 12px;"><span style=3D"color: rgb(143, 149, 158);">Discl=
aimer: This email is intended to be read only by the designated recipient o=
f the document and has high confidentiality requirements. Anyone else is pr=
ohibited from using, opening, copying or forwarding any of the contents ins=
ide. If this email was sent to you by mistake, please contact the sender of=
 the email and delete this file immediately. Confidentiality and legal priv=
ileges are not waived or lost by misdirected emails. Any views or opinions =
expressed in the email are those of the author and do not necessarily repre=
sent those of the Company.</span></span><span style=3D"font-size: 12px;"><s=
pan style=3D"font-family: helvetica;"><span style=3D"color: rgb(143, 149, 1=
58);">
</span></span></span></div></div><div data-zone-id=3D"0" data-line-index=3D=
"3" data-line=3D"true" style=3D"white-space: pre-wrap; margin-top: 4px; mar=
gin-bottom: 4px; line-height: 1.6;"><br></div>
--784af078e0a4c6ced8ad7a6c349662478a0acecac519abef303be6560fe0--

--c61732073438e75300aa435d45534b538daa8b593736e711dc3a6d49ee40
Content-Disposition: attachment; filename="0001-mm-rmap-Correct-stats-calulation-in-__folio_remove_r.patch"
Content-Transfer-Encoding: base64
Content-Type: application/octet-stream; name="0001-mm-rmap-Correct-stats-calulation-in-__folio_remove_r.patch"

RnJvbSA0MWMzOGMxZWJiNDc4OGU0MGYxMDMyNjBlZTBhZDY4MjYzNzBlMDQzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBzaGlzaXl1YW4gPHNoaXNpeXVhbkBsaXhpYW5nLmNvbT4KRGF0
ZTogRnJpLCAxNCBKdW4gMjAyNCAxNTozMjoyMyArMDgwMApTdWJqZWN0OiBbUEFUQ0hdIG1tOiBy
bWFwOiBDb3JyZWN0IHN0YXRzIGNhbHVsYXRpb24gaW4gX19mb2xpb19yZW1vdmVfcm1hcAoKU2ln
bmVkLW9mZi1ieTogc2hpc2l5dWFuIDxzaGlzaXl1YW5AbGl4aWFuZy5jb20+Ci0tLQogbW0vcm1h
cC5jIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0p
CgpkaWZmIC0tZ2l0IGEvbW0vcm1hcC5jIGIvbW0vcm1hcC5jCmluZGV4IDUyMzU3ZDc5OTE3Yy4u
ZjlhZWFiZDY5MWZhIDEwMDY0NAotLS0gYS9tbS9ybWFwLmMKKysrIGIvbW0vcm1hcC5jCkBAIC0x
NTY3LDcgKzE1NjcsNyBAQCBzdGF0aWMgX19hbHdheXNfaW5saW5lIHZvaWQgX19mb2xpb19yZW1v
dmVfcm1hcChzdHJ1Y3QgZm9saW8gKmZvbGlvLAogCQkgICAgbGlzdF9lbXB0eSgmZm9saW8tPl9k
ZWZlcnJlZF9saXN0KSkKIAkJCWRlZmVycmVkX3NwbGl0X2ZvbGlvKGZvbGlvKTsKIAl9Ci0JX19m
b2xpb19tb2Rfc3RhdChmb2xpbywgbnIsIG5yX3BtZG1hcHBlZCk7CisJX19mb2xpb19tb2Rfc3Rh
dChmb2xpbywgLW5yLCAtbnJfcG1kbWFwcGVkKTsKIAogCS8qCiAJICogSXQgd291bGQgYmUgdGlk
eSB0byByZXNldCBmb2xpb190ZXN0X2Fub24gbWFwcGluZyB3aGVuIGZ1bGx5Ci0tIAoyLjM0LjEK
Cg==

--c61732073438e75300aa435d45534b538daa8b593736e711dc3a6d49ee40--


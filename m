Return-Path: <linux-kernel+bounces-399335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E0F09BFD9C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 06:23:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14FE01F221F3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 05:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD2919048F;
	Thu,  7 Nov 2024 05:23:13 +0000 (UTC)
Received: from r9206.ps.combzmail.jp (r9206.ps.combzmail.jp [160.16.62.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC18E56C
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 05:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.16.62.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730956992; cv=none; b=laXLkJy7JxoDg7qQJGK0IkCAHN0Jukz/1/eG8CPE4F76SmaXjIvru6pe5eCrFLZm8SDCC1hDMso9N3GL9OzyeiZ3N8uEWBIqNFieQl752gn8EdVoZdfE/U81W6PlNEpaPaIW+ODSRUozMJ/Pft4I+umPJAbEYL2qjTOkMXsYo+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730956992; c=relaxed/simple;
	bh=dbm/QjVHZJgLLtEbBc7U0i/yH2LO0zDbn/poTgx5X/M=;
	h=To:From:Subject:Mime-Version:Content-Type:Message-Id:Date; b=LNLlkgehA0fl4bjuAnZtjRKbzxg1CIqzt5MwCdpvxOxvNrNw2IGWl39LvHV4hV5SfLpZnWD2wEQTIUEvKKKCvcerY6jQm4y7r2ZNzHp46Uek+pbmN9IXpNo9GeOse6paXdpxYPcHouzxbHx+zU3Pba2PgH+ANnLESCMdWWkxlyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kids-developer.jp; spf=pass smtp.mailfrom=magerr.combzmail.jp; arc=none smtp.client-ip=160.16.62.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kids-developer.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=magerr.combzmail.jp
Received: by r9206.ps.combzmail.jp (Postfix, from userid 99)
	id 432591034F2; Thu,  7 Nov 2024 14:22:58 +0900 (JST)
DKIM-Filter: OpenDKIM Filter v2.11.0 r9206.ps.combzmail.jp 432591034F2
To: linux-kernel@vger.kernel.org
From: Kids Developer<info@kids-developer.jp>
X-Ip: 942501524504899
X-Ip-source: k85gj72z48dnsak7u0p6gd
Precedence: bulk
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Subject: =?ISO-2022-JP?B?GyRCO3Y2SCRyREwkOCQ/PFIycTlXOCUbKEI=?=
 =?ISO-2022-JP?B?IBskQiE/GyhCIBskQjt5RjhIL0MjO1kxZzt2NkgbKEI=?=
 =?ISO-2022-JP?B?IBskQkBiTEAycRsoQg==?=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
X-MagazineId: 2zk7
X-uId: 6762324543485867604543521021
X-Sender: CombzMailSender
X-Url: http://www.combzmail.jp/
Message-Id: <20241107052308.432591034F2@r9206.ps.combzmail.jp>
Date: Thu,  7 Nov 2024 14:22:58 +0900 (JST)

$B$$$D$b$*@$OC$K$J$j$^$9!#(B


$BG>2J3X$K4p$E$/650i$G;R$I$b$?$A$r0i$F$k(B

$B!!;yF8J!;c;v6H!J;yF8H/C#;Y1g!&J|2]8eEy%G%$%5!<%S%9!K(B

$B$N%U%i%s%A%c%$%:@bL@2q$r$*CN$i$;$$$?$7$^$9!#(B


$B6H3&7P83$rLd$o$:$K;O$a$i$l$k;v6H$G$9$N$G!"(B

$B!V;R6!$?$A$NL$Mh$K@UG$46$r;}$C$F!"<R2q9W8%;v6H$K<h$jAH$_$?$$!W(B

$B$H$*9M$($NJ}$O!"$<$R@bL@2q$K$4;22C$/$@$5$$!#(B



$B!!"'!!@bL@2q$N>\:Y3NG'$H;22C?=9~$_$O(B
$B!!!!!!2<5-(BURL$B$K$F$*4j$$$7$^$9!#(B
$B!!!!!!(Bhttps://fc-jidou-support.jp/2400/



$B!!"#!!%U%i%s%A%c%$%:%7%9%F%`@bL@2q(B

$B!!!!!!G>2J3X$K4p$E$/650i$G!";R$I$b$?$A$r0i$F$k(B
$B!!!!!!;yF8H/C#;Y1g!&J|2]8e%G%$%5!<%S%9(B
$B!!!!!!!H!!%-%C%I%"%+%G%_!<(B $B%W%i%9!!!I(B


$B!!"#!!F|Dx!J%*%s%i%$%sG[?.!K(B
$B!!!!!!(B
$B!!!!!!(B11$B7n(B12$BF|!J2P!K(B10:00$B!A(B11:00$B!?(B15:00$B!A(B16:00
$B!!!!!!(B11$B7n(B15$BF|!J6b!K(B10:00$B!A(B11:00$B!?(B15:00$B!A(B16:00
$B!!!!!!(B11$B7n(B19$BF|!J2P!K(B10:00$B!A(B11:00$B!?(B15:00$B!A(B16:00
$B!!!!!!(B11$B7n(B22$BF|!J6b!K(B10:00$B!A(B11:00$B!?(B15:00$B!A(B16:00
$B!!!!!!(B11$B7n(B26$BF|!J2P!K(B10:00$B!A(B11:00$B!?(B15:00$B!A(B16:00
$B!!!!!!(B11$B7n(B29$BF|!J6b!K(B10:00$B!A(B11:00$B!?(B15:00$B!A(B16:00


$B!!"#!!BP>](B

$B!!!!!!?75,;v6H$r$*9M$(7P1D<TMM!J6H3&7P83$OLd$$$^$;$s!K(B


$B!!"#!!;22CHqMQ(B

$B!!!!!!L5NA(B


$B!!"'!!@bL@2q$N>\:Y3NG'$H;22C?=9~$_$O(B
$B!!!!!!2<5-(BURL$B$K$F$*4j$$$7$^$9!#(B
$B!!!!!!(Bhttps://fc-jidou-support.jp/2400/



$B!!""!!;yF8H/C#;Y1g!?J|2]8eEy%G%$%5!<%S%9$H$O!)(B $B""(B

$B!!!!!!J?@.(B24$BG/;\9T$N;yF8J!;cK!$K4p$E$/(B
$B!!!!!!>c$,$$$N$"$k;R$I$b8~$1$NJ!;c%5!<%S%9$G$9!#(B

$B!!!!!!!V;yF8H/C#;Y1g!W(B
$B!!!!!!$OL$="3X;y!J(B0$B:P!A(B6$B:P!K8~$1$N%5!<%S%9$G!"(B
$B!!!!!!H/C#;Y1g$d$=$N2HB2$X$N;Y1g$r9T$$$^$9!#(B
$B!!!!!!MDCU1`$d>.3X9;F~3X$K8~$1$?=8CD@83h$X(B
$B!!!!!!$NE,1~71N}$J$I$b$"$j$^$9!#(B

$B!!!!!!!VJ|2]8eEy%G%$%5!<%S%9!W(B
$B!!!!!!$O="3X;y!J(B6$B:P!A(B18$B:P!K8~$1$N%5!<%S%9$G!"(B
$B!!!!!!J|2]8e$d5YF|$KMxMQ$G$-!"<+N);Y1g$HF|>o@83h$N(B
$B!!!!!!=<<B$N$?$a$N3hF0$r<B;\$7$^$9!#(B



$B!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=(B

  $B3t<02q<R(BKidsDeveloper
$B!!J<8K8)?@8M;TElFg6h8~MND.Cf#6CzL\#9(B 10E07$B9f(B
$B!!(B078-230-1170

$B!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=(B

$B!!$40FFb$N$4ITMW$JJ}$K$OBgJQ<:Ni$$$?$7$^$7$?!#(B
$B!!2<5-(BURL$B$K$FG[?.Dd;_$r>5$C$F$*$j$^$9!#(B
$B!!!!(Bhttps://fc-jidou-support.jp/mail/
$B!!$^$?$O!"$3$N%a!<%k$N7oL>$K!VG[?.ITMW!W$H5-:\$N$&$((B
$B!!$4JV?.$$$?$@$/$3$H$G$b>5$C$F$*$j$^$9!#(B

$B!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=(B


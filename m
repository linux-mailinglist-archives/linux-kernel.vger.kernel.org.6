Return-Path: <linux-kernel+bounces-511060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86441A3253C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 12:47:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA16F188A0A9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 11:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11D6520A5EE;
	Wed, 12 Feb 2025 11:47:55 +0000 (UTC)
Received: from sub0000529476.hmk-temp.com (mail.btob-mail.work [180.222.184.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33BAA1DDA1B
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 11:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.222.184.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739360874; cv=none; b=b3ucCpkXLZJw7yh2K2KnsbVvlBeuA4YEuPrdtwSRU/zAAlCrFqcTQwIkXGJXyctjrPADLcTnsYYURWubDIJqaJejhk5f4hI01l7yS0p97HdrB1q4gY2RjmdWlR3YEmOuDO6Xwlozu+ai/sop0O5jjDayC+ya74KiovPykubjktA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739360874; c=relaxed/simple;
	bh=s5RkDWMsPAAnwYzVTws6XjcFf+hcblKo4FwS7fr7Sis=;
	h=From:To:Subject:Content-Type:Date:Message-ID; b=Xi0/+Vbkmxm+y20pEGr590x99p76qZDb/pL2tla+7ZW3NRizeRIAcufmA35o1NHz7+0Z1BMjQdiF63Yj4P9I5xBNuPwKsr8HECrE0xr/+viedv89Ggjzh3XfHX2CyJhbeyCEPU7h3pKt+wLSVROth8tL6mY7IMdi4qx6ElMVofA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=saiyo-shien.biz; spf=fail smtp.mailfrom=saiyo-shien.biz; arc=none smtp.client-ip=180.222.184.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=saiyo-shien.biz
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=saiyo-shien.biz
Received: (qmail 377 invoked from network); 12 Feb 2025 15:10:16 +0900
Received: from ai126146095188.53.access-internet.ne.jp (HELO DESKTOP-K0R8I4G) (126.146.95.188)
  by mail.btob-mail.work with ESMTPSA (DHE-RSA-AES256-GCM-SHA384 encrypted, authenticated); 12 Feb 2025 15:10:16 +0900
From: =?iso-2022-jp?B?V2l6Qml6GyRCM3Q8MDJxPFIbKEI=?= <info@saiyo-shien.biz>
To: linux-kernel@vger.kernel.org
Subject: =?iso-2022-jp?B?GyRCNDE4eEQjJCw1LjxSPiY6YCRyR2MkJCReJDkbKEI=?=
X-Mailer: Mail Magic Professional Version 16
Content-Type: text/plain;
	charset=iso-2022-jp
Date: Wed, 12 Feb 2025 16:03:55 +0900
Message-ID: <202502121603550840.61AC5E50E9B44E719672592F716E3705@btob-mail.work>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

$B$*@$OC$K$J$C$F$*$j$^$9!#(B
WizBiz$B3t<02q<R$G$4$6$$$^$9!#(B

$B$5$^$6$^$J7P1D$N$*Lr$KN)$D>pJs$r$*FO$1$7$F$*$j$^$9!#(B

$B9q!J!a418xD#!K$,Cf>.4k6H$H$N<h0z$K;H$&HqMQ$H$7$F(B
$BM=;;2=$7$F$$$k6b3[$O!"Ls(B5$BC{(B6,000$B2/1_!JNaOB(B5$BG/EY!K!#(B
$B<B:]$K9q$H<h0z$r$7$F$$$k4k6H$OA4BN$N!V(B15%$B!W$7$+$"$j$^$;$s!"(B

$B$3$l$@$1Bg$-$JM=;;!a%^!<%1%C%H$r$$$+$K96N,$9$l$PNI$$$N$+!)(B
$B$=$s$J5?Ld$r(B55$BJ,$G2r>C$9$kL5NA%;%_%J!<$r3+:ECW$7$^$9!#(B

$B"!%*%s%i%$%s%;%_%J!<$N>\:Y!&$*?=9~$_$O$3$A$i!JL5NA!K(B
https://wizbiz.jp/seminar/40384/

$B9q!a418xD#$H$$$C$F$b!"1D6H%?!<%2%C%H$K$J$k$N$O!"2b$,4X$NCf1{>JD#$@$1$G$O$"$j$^$;$s!#(B
$BA49q3FCO$K%?!<%2%C%H$O$"$j$^$9!#A49q$K$I$l$/$i$$418xD#$,$"$k$N$+$rD4$Y$F$_$^$7$?!#(B

$B!AKL3$F;!&ElKLCOJ}!A(B 1017$B@h(B
$BKL3$F;!"@D?9!"4d<j!"5\>k!"=)ED!";37A!"J!Eg$N#7F;8)(B

$B!A4XElCOJ}!A(B 1297$B@h(B
$B72GO!"FJLZ!"0q>k!":k6L!"@iMU!"El5~!"?@F`@n!";3M|$N#8ET8)(B

$B!ACfItCOJ}!A(B 755$B@h(B
$B@E2,!"0&CN!"4tIl!";0=E!"J!0f!"@P@n!"IY;3!"?73c!"D9Ln$N#98)(B

$B!A6a5&COJ}!A(B 534$B@h(B
$B<"2l!"5~ET!"F`NI!"OB2N;3!"Bg:e!"J<8K$N#6I\8)(B

$B!ACf9q!&;M9qCOJ}!"6e=#!&2-FlCOJ}!A(B 1,328$B@h(B
$B2,;3!"9-Eg!";38}!"D;<h!"Eg:,!"9a@n!"0&I2!"FAEg!"9bCN!"J!2,!":42l!"D9:j!"BgJ,!"7'K\!"5\:j!"</;yEg!"2-Fl$N(B17$B8)(B
$B!J=gITF1!K(B

$B3FCO$K$3$l$@$1$N418xD#!a9q$N9T@/5!4X$,$"$j$^$9!#!J(BWizBiz$B3t<02q<RD4$Y!K(B

$B<B$O!"3'$5$s$NCO85$K$"$k$3$l$i9q$N9T@/5!4X$,!"(B
$B?75,3+Bs$K$O$&$C$F$D$1$J$N$G$9!#(B $B$=$NM}M3$O!&!&!&(B

$B!z9q$N9T@/5!4X$OCO85$NCf>.4k6H$H<h0z$7$J$1$l$P$J$i$J$$$H$$$&K!N'$,$"$k(B
$B!z$=$N$?$a$NG/4VM=;;$O!"#5C{#6@i2/1_$rD6$($k!JNaOB(B5$BG/EY<B@S!K(B
$B!zF~;%0J30$K$b9q$H<h0z$9$kJ}K!$,$"$k$N$K!"$=$s$J$3$H$rCN$C$F$$$k7P1D<T$O$[$H$s$I$$$J$$(B
$B!z<B:]$K!"9q$H<h0z$7$F$$$kCf>.4k6H$O$o$:$+(B15$B!s$7$+$$$J$$(B
$B!z$D$^$jA49q$N(B15$B!s$N4k6H$G#5C{#6@i2/1_$,FH$j@j$a$5$l$F$*$j!"(B85$B!s$N4k6H$O2cD"$N30$K$$$k(B

$B$D$^$j9q$O!"CO85Cf>.4k6H$H<h0z$9$k$?$a$K=`HwK|C<$J$N$K!"(B
$BCf>.4k6HB&$,%"%W%m!<%A$7$F$$$J$$$N$G$9!#(B

$B$3$N;v<B$K!"$b$C$?$$$J$$$H46$8$?7P1D<TMM!"(B
$B$<$R0lEY%;%_%J!<$r$*J9$-$K$J$j!"9q$H$N<h0z$K%A%c%l%s%8$7$F$_$^$;$s$+!)(B

$B"!%;%_%J!<$N>\:Y!&$*?=9~$_$O$3$A$i!JL5NA!K(B
https://wizbiz.jp/seminar/40384/

$B!Z%;%_%J!<$G2r@b$9$kFbMF$r0lIt$4>R2p!*![(B

$B!}9q$OCf>.4k6H$H<h0z$7$J$1$l$P$J$$$i$J$$!"$H$$$&!VK!N'!W(B
$B!}Gd>e%"%C%W0J30$K$bB8:_$9$kBg$-$J%a%j%C%H(B
$B!}$I$&$d$C$F9q$H?75,<h0z$r$9$l$P$$$$$N$+!)(B
$B!}<B:]$KH/Cm$r<u$1$?Cf>.4k6H$,9q$+$iLc$C$F$$$k6b3[(B

$B%^%$%/!"%+%a%iITMW$NL5NA%;%_%J!<$H$J$C$F$*$j$^$9!#(B
$B$*5$7Z$K$4;22C$/$@$5$$!#(B

$B"!%;%_%J!<$N>\:Y!&$*?=9~$_$O$3$A$i!JL5NA!K(B
https://wizbiz.jp/seminar/40384/

===================================
$B%a!<%k$NG[?.Dd;_$r$44uK>$NJ}$O$*<j?t$r$*3]$1$7$^$9$,!"(B
$B0J2<$h$j$*<jB3$-$r$*4j$$CW$7$^$9!#(B
https://form.os7.biz/f/ed730f94/
===================================
$B1?1D2q<R!'(BWizBiz$B3t<02q<R(B
$B=;=j!'El5~ET9A6h<G(B5-16-7$B!!<G%S%k(B3F
$BEEOC!'(B03-6809-3845
$B(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(B


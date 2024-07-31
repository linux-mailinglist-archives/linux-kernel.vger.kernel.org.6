Return-Path: <linux-kernel+bounces-269530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68BAA9433DF
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 18:09:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EBE01C20D1B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 16:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F7631BBBD9;
	Wed, 31 Jul 2024 16:09:18 +0000 (UTC)
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E458B171AF
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 16:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722442158; cv=none; b=QzXMEG8EDM7qX9ZMonVbHGBFI5nJAZM9HX1f1W04DUIlwU+55SXoJPhy2tPWNcsmT/o5AILAX22XasNopksqU7dN5nx7sAfvui5L8e1eLL4X/WKTL01JebYIIs2jANmNbY8p/L7ZKjw72YKiVmG+TvrxH+ku6rbKE5QaKNkp6DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722442158; c=relaxed/simple;
	bh=K6dbgpXwLZIztDeHX29B4LgMK9GUn/muyr5rZ8zcBtQ=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=XHNe0MaKEDfGuKXP7yRW85b/vABRg+JILwYlHxzTQVo0uf02bs8rkFmi4tl/LCh5xkSnQFi5bSZJEaJsj0c+LPNqKxP/0xKVA7dJlgrm4atr7Jy5BSKPnmTmqANZmYTAtz4kfMh/AOSpDnchuV+YpsP26cEnJS7B2nLXbZUyziA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eipi.fun; spf=pass smtp.mailfrom=eipi.fun; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eipi.fun
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eipi.fun
X-QQ-mid: bizesmtp87t1722442132t327ed28
X-QQ-Originating-IP: jwUbDvYvGU1K4Kwur+CFHh6H+fgrSe4ZGyojye9zlVs=
Received: from [192.168.0.9] ( [118.38.173.226])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 01 Aug 2024 00:08:50 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4618790565118997799
Message-ID: <D20EAB24BCB3973E+206e698e153d5379aa8183d9446ab545e758382c.camel@eipi.fun>
Subject: [PATCH] code indent,
 drivers/staging/rtl8723bs/include/rtw_security.h
From: EiPiFun <me@eipi.fun>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-staging <linux-staging@lists.linux.dev>, linux-kernel
	 <linux-kernel@vger.kernel.org>
Date: Thu, 01 Aug 2024 01:08:49 +0900
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:eipi.fun:qybglogicsvrgz:qybglogicsvrgz5a-1

From 816921cbfa76a1cfd0cb1ca93a9df0f2a429bc3a Mon Sep 17 00:00:00 2001
From: EiPi Fun <me@eipi.fun>
Date: Tue, 30 Jul 2024 07:28:38 +0000
Subject: [PATCH] code indent should use tabs where possible

---
=C2=A0drivers/staging/rtl8723bs/include/rtw_security.h | 4 ++--
=C2=A01 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/rtw_security.h
b/drivers/staging/rtl8723bs/include/rtw_security.h
index c3e47d526..89c1d5ae1 100644
--- a/drivers/staging/rtl8723bs/include/rtw_security.h
+++ b/drivers/staging/rtl8723bs/include/rtw_security.h
@@ -75,8 +75,8 @@ struct {
=C2=A0};
=C2=A0
=C2=A0union Keytype {
-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u8=C2=A0=C2=A0 skey[16];
-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u32=C2=A0=C2=A0=C2=A0 lkey[4];
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u8=C2=A0=C2=A0 skey[16];
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u32=C2=A0=C2=A0=C2=A0 lkey[4];
=C2=A0};
=C2=A0
=C2=A0



Return-Path: <linux-kernel+bounces-524522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DC9BA3E417
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 19:40:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3925F18898C6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 18:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18906213E6C;
	Thu, 20 Feb 2025 18:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hillapex-8.site header.i=@hillapex-8.site header.b="qlMWCuGI"
Received: from mail.hillapex-8.site (mail.hillapex-8.site [92.113.147.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCAB71487E9
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 18:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.113.147.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740076808; cv=none; b=fgTe5NMWpxHqDBSiPwLQxsIU3/h7AjRz0NW0sndfwz3ynWTYBHe4Kw+FoOf3S8BKunIo+OD1aeB/Y3y2VMEkSn1fAkZ/D2w3P707QWWzHzj0G6r1H5bgKa3cPI1pofmFfhrO+eDp91rzldEWlVI+xdn3pAcz9wHCgyhmckIQp9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740076808; c=relaxed/simple;
	bh=PdsMbBAF/OUQAFCOucNpNTA0P2eutQfnDF6WpSM73Hs=;
	h=Message-ID:From:To:Subject:Date:MIME-Version:Content-Type; b=t7okddtKoW6FjDBVlEgUJRm69K+Wddlq5jUlpmCi7Po/livRkqoohuskWDT0GHmbYbPdqQ7rNFFZfnmRsn6qofu/05egGxulirdHwlV6idO9LVOi54GDDUkBAx3OYr8kN1ek2shCiTwkrz9ThN7EX5XX86HVFr87qj/5sH5X/6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hillapex-8.site; spf=pass smtp.mailfrom=hillapex-8.site; dkim=pass (2048-bit key) header.d=hillapex-8.site header.i=@hillapex-8.site header.b=qlMWCuGI; arc=none smtp.client-ip=92.113.147.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hillapex-8.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hillapex-8.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hillapex-8.site;
	s=default; t=1740076771;
	bh=2n11Zu0md9PxChiVD4IoSSvrvvNTm4OZzq38NYa6lzA=;
	h=Received:Received:From:To:Subject;
	b=qlMWCuGI1/JiojpnAuysoDa2clmDUd6mSoEE4NGrjBdNCvI/7nZl72nYiEo4HiNRK
	 xxzQlMA//V4m780FI+CwrXPPOWsgY8mdgnaxwC3jHn1S4/UdD1xMz70RxU1jqBm5U+
	 CADgTxzQ7OjQb609p9VhUHbFSIf1n6equN6aPthY0jx6fNQNuswXP6SVdGwggIN/kc
	 Y9iJ0oPgBhi2DS/LqW/5i6kHPQt5l6MAEd0JeG7rHgO+A11K3k8Xv8VbzFE1OS6b8V
	 m63XO93Up9lY2pp+TfqNB5KSecwpypKU1N1VFVvhGdvXKLzl5LGPzrEE9gj1dfuO0j
	 boCNmiJSCPaNQ==
Received: (qmail 776969 invoked from network); 20 Feb 2025 18:32:51 +0000
Authentication-Results: mail.hillapex-8.site;
        spf=pass (sender IP is 39.63.200.206) smtp.mailfrom=saad@hillapex-8.site smtp.helo=Knrybfx
Received-SPF: pass (mail.hillapex-8.site: connection is authenticated)
Received: from unknown (HELO Knrybfx) (39.63.200.206)
  by mail.hillapex-8.site with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted,
 authenticated); 20 Feb 2025 18:32:50 +0000
Message-ID: <6D2C1F19E42287549213DEC24D696473@Knrybfx>
From: <saad@hillapex-8.site>
To: <linux-kernel@vger.kernel.org>
Reply-To: <saad@hillapex.com>
Subject: Sports bag backpack & sportswear
Date: Thu, 20 Feb 2025 23:33:21 +0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5843
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.5579
X-PPP-Message-ID: 
 <174007637123.776964.8469039975705701995@exciting-pascal.92-113-147-146.plesk.page>
X-PPP-Vhost: hillapex-8.site

Hi linux-kernel@vger.kernel.org

We make sublimated sports bags, backpacks, and sportswear. To get delivery prices, please:

1. Visit hillapex.com and pick an item.
2. Let us know your order quantity.
3. Provide your country name.

Best regards,
Saad Afzal

Hill Apex
Website: hillapex.com
Email: hill.apex.1@gmail.com
Contact:  0092 300 7101027
WhatsApp: 0092 300 7101027
Chenab ranger's road
51310 Sialkot Pakistan


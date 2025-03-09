Return-Path: <linux-kernel+bounces-552876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C7CA58049
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 03:03:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DDAD3AFAF2
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 02:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F64017BD6;
	Sun,  9 Mar 2025 02:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="SFtmHGhe"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50108F49
	for <linux-kernel@vger.kernel.org>; Sun,  9 Mar 2025 02:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741485799; cv=none; b=U9Wkl5TwjGSTO7r6PhNCRWlYriVPHe+bzH9p5tkAEa+yItS2/14IH+COYmE08fmT8MNiw7CvZGGs+aXFNOiMYjRjg2gvlYMqLKAYiyWZzBbH26log6rqqO3jHcSRTQSzKW6sabk8Z08QrM6FbzRmWCNPJ6anW9psktFtuVf3Q+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741485799; c=relaxed/simple;
	bh=LTCdmIDxl6XOz/+PFPIsks/OTB5dnydVf2mag/cLPAw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=is5Ivf6fl0xC5kAl/CfHHZi7HMWrtUUYSzeXkhRtgHTbPSmmnLFWB2m4xaZVndCn1gmh/9bJjvNrOrfuxcujKzvE7uc4TtCA/mCGRaDY3iGN1ZZ+7AIANJD14o/whHh0nvIlzq5xgo9W3bcxZiYtlYpvXu9mg/meYdMzYm3TPa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=SFtmHGhe; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=BWyX2zEnjkS9tlmza9dXLUlzJeH8gIoG0txg9U7jwG8=; b=SFtmHGheGFFObyRq
	OFVyCQ64zP0TxlNShyfGQoREGjKOTNZG/Nw3G3QzZw+5jpX5hlqUQfvRZNv0T7OG4R2+sfgg53VkZ
	mwSpr6oKJ4Sb+LalFRX/MHMxXWfdjIMftZovzLgoMVxOY2uXbiiPMs2XNBZKY81lkRsLBHyGLQirJ
	rB01L+uMhZPJlU9KrHDiCZdkVnx5z/4mU++tX0RNyRJN6eJK1QR2pqLPT/DQ+0Vv768LXMAcd8hD/
	twnrJowErD6gbGr+4J0r2NxSCCX0ufHBmXEUM7Me2a99jxwmG2FMp6TAGmBIHyEsDXJuZmoez/cTb
	etmC0ZaBDP17NSAqBw==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1tr60V-003fOG-1G;
	Sun, 09 Mar 2025 02:03:11 +0000
Date: Sun, 9 Mar 2025 02:03:11 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: arnd@arndb.de, lee@kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: the pcf50633 - dead?
Message-ID: <Z8z236h4B5A6Ki3D@gallifrey>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 01:55:02 up 304 days, 13:09,  1 user,  load average: 0.00, 0.00,
 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

Hi Arnd,
  My scripts noticed pcf50633_adc_sync_read and a load of other
pcf50633 symbols weren't called; and hmm I'm pretty sure most of it's
dead.
  Your:
 61b7f8920b176e3cb86c3b5e7c866261720a7917 
  ARM: s3c: remove all s3c24xx support
removed the last/only includes of any of the pcf50633 headers,
I think it was part of openmoko.
The only place I see it enabled (=m) in a config is
arch/mips/configs/ip27_defconfig  which is the ancient SGI Onyx
which predates the pcf50633 by a good few years (and is definitely
not portable and battery powered!)

Dave
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/


Return-Path: <linux-kernel+bounces-410758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B59929CE0E5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 15:05:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B72FB2B10F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 13:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EB991CEAD6;
	Fri, 15 Nov 2024 13:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="KSxEUOSq"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C26C1CDA3F
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 13:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731678608; cv=none; b=XsIF8dq7raqK80U5zKd+37j9oKtdCfiQjl0NepeMkBnH3he9UKX0ZxmI76ykLKRwiC5eGtBRgxcsluJ/H98ZXGluHh3Yp3y9kVtCLTNEt8q3+V4pwlCF/Um+2F8VJkxGCsSsKlSMqkW94IM887eCMslEC6NDgwlAmkfbBZ1xsK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731678608; c=relaxed/simple;
	bh=VTbbpQ7Lcq7KZH8ikNE/7PSqZiN/fmJgz4kJgTVigrs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=gFOsI4j2nVA/BWJxIuATcNNY69GM+PZHqpE1/vbhv78XBbNxRfvIkdmmJ5ogHSp7qe+r/ABlAcQkqVPj6Ixz2PtyKtce+ndj7HzOE6gb2t+0+xf7S3tHoK+awdtSsKIPyYToUhN+tG+E96sBkMq2dVu6xToRV7I+72jjG7hkj4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=KSxEUOSq; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=Ndqdzs9YtXl3x0qBO/nHaiv+prRAsf+vu2Bj3bBIyF0=; b=KSxEUOSqpT+cdn2e
	EkxnDwvc9POkldDx0J12j7BPsM1erLaKv4+pNOZnJP/OdQvYcgkABQlEbkdNiKOpMQYjX3F5GJ62+
	xudIn8m4DY1wDm16tR1cGtF5e2s5dYfVCJ17VfqrY5VDiKQzC47wVZl21TDc/8SwRXA6xW1GAaQGz
	Zrx9/Jud+Jd9OwUVnOAibJWvRxyXkrSZAOaL9ZY1VupU617mMqfTdA+gCr1NsFOZmA44rWt0RWM5w
	43JOmx9WmH9a1vd4RBk9OFocsvHmTu8SPSisdr4KE+kob7e7u7Ttv6p2vZKTyu78702pncbgn6lu+
	ZGJPhDdvxts6OMNqhA==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1tBwhx-0007bE-1W;
	Fri, 15 Nov 2024 13:49:57 +0000
Date: Fri, 15 Nov 2024 13:49:57 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: stuyoder@gmail.com, laurentiu.tudor@nxp.com, ioana.ciornei@nxp.com
Cc: linux-kernel@vger.kernel.org
Subject: Of fsl_mc_allocator_driver_exit
Message-ID: <ZzdRhcE2kG5z6NLk@gallifrey>
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
X-Uptime: 13:43:46 up 191 days, 57 min,  1 user,  load average: 0.16, 0.08,
 0.02
User-Agent: Mutt/2.2.12 (2023-09-09)

Hi,
  One of my scripts noticed that fsl_mc_allocator_driver_exit()
was added explicitly in
commit 1e8ac83b6caf ("bus: fsl-mc: add fsl_mc_allocator cleanup function")

but appears to be unused; given it's a cleanup function it feels like
it should be wired up _somewhere_.

However, I know nothing of this driver, so it feels best to ask you.

Thanks in advance,

Dave

-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/


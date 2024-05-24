Return-Path: <linux-kernel+bounces-189087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 15EF88CEAD5
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 22:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98F5CB21384
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 20:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BAEA74E10;
	Fri, 24 May 2024 20:25:52 +0000 (UTC)
Received: from mta11.doruk.net.tr (mta11.doruk.net.tr [81.21.172.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BCF846542
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 20:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.21.172.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716582351; cv=none; b=aD5cBAJGSzElBkCFWVNpkKa2ixFNdG5ZmWhoSK9YnKwPm6kGg24U5NP5EnEtGb68J3GyKCzyzFpgEAD7ZJdgd/ZcFg/2NXsoDxGokjM36/P5lcDIHTwJY7GSrAJt3EVGw5GkkXEyg8ABo+3MIodHw7wF2dRVVgJ6mBZ0GMpoc0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716582351; c=relaxed/simple;
	bh=/lp3Rwc0p0B4ZHQnRGocmeMmoBWLClruGn+qDx6fs4U=;
	h=Content-Type:MIME-Version:To:From:Subject:Message-ID:Date; b=ncbZ98xkA1UPN1SJgjwWxEP76LTowqT40oo9CaArojiXzNQPv9e77+dWHkCXt9j/jbgot2IyRe6CgVnAZ92bXuxCxAcuxuFs4jhc7cDnc2gHslhW7lzAppz7Y3kZhh4+rgnyWkEfwg3rOTndTg+eNkE2Xjcl5YzWXqAZYrwH/lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gemak.biz; spf=pass smtp.mailfrom=gemak.biz; arc=none smtp.client-ip=81.21.172.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gemak.biz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gemak.biz
Received: from cmail11.webkontrol.doruk.net.tr ([212.58.2.42]:62870)
	by mta11.doruk.net.tr with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.90_1)
	(envelope-from <cihan@gemak.biz>)
	id 1sAaQ0-000Ao5-10
	for linux-kernel@vger.kernel.org; Fri, 24 May 2024 22:17:32 +0300
Received: from [127.0.1.1] ([121.127.33.252])
        by cmail11.webkontrol.doruk.net.tr (13.0.3 build 11 ) with ASMTP (SSL) id 202405242217307857
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 22:17:30 +0300
Reply-To: linda.smith@marsaveton.com
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.6-Rev57
X-Originating-Client: open-xchange-appsuite
X-OX-Marker: b0483612-72e5-4a04-924d-deb1afed12f4
Content-Type: multipart/mixed; boundary="===============6990953336973176939=="
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: "cihan@gemak.biz" <cihan@gemak.biz>
Subject: Help Needed Regarding a Mysterious Charge on My Statement
Message-ID: <14b7286e15dc92c467813b5a470b4ed7@gemak.biz>
Date: Fri, 24 May 2024 22:17:32 +0300

--===============6990953336973176939==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Hello,

I hope this message finds you well. I recently looked over my billing statement and observed a transaction from your store that I do not remember. The expense appears unknown to me, and I would appreciate your help in understanding it further.

Could you please offer clarification on this charge? Any information you can give would be greatly valued.

Thank you for your prompt attention to this matter.

Sincerely,
Linda Smith
--===============6990953336973176939==--


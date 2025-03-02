Return-Path: <linux-kernel+bounces-540238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0D26A4AF93
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 07:48:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4964B3B60CC
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 06:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B81831EF363;
	Sun,  2 Mar 2025 06:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="XQf/HGpV"
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.7])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72CC11D5173
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 06:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740897866; cv=none; b=qhoIqCn7UuHWSwnY4U6KJBRCh2Tet057qXmMWnsxhgFJ3+K+RhlRZRdH1s6xHMVux4/GOwVJBgalb++ObCZi5f4QCe6oTjqzcGDYAfiu8kS/VLQnEzpFlha37FJzXoTOTSl7XE1HCPCK1jDi/t5BOC0mLyyleBqWtyRXK75fNe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740897866; c=relaxed/simple;
	bh=jOTe+0xUMEm8LLQEkXE6MviC3n7NMHX44e0k2GAwts0=;
	h=From:To:Cc:Subject:MIME-Version:Content-Type:Message-Id:Date; b=A7DdLQkKko416X2y0j/ruhDbXHCJnLu8Bwu51YWfz1T+Zj8Hyc50KnYpt0c7du/Hkdk1rEAz7VmUfvtXsPDl209kvoWw2ceAz8vs71GLiJpyGLbyxeIACXEUE31jTbryeUW4pBkvqwuSb5WSVRuu/SK7KYyzCl8XQo5L+rlgH4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=XQf/HGpV; arc=none smtp.client-ip=117.135.210.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:MIME-Version:Content-Type:Message-Id:
	Date; bh=jOTe+0xUMEm8LLQEkXE6MviC3n7NMHX44e0k2GAwts0=; b=XQf/HGp
	VT25goWpfILee2ttDtX0g9gjF63fpWgIb6Lb0izLFZWBumAFx/mWVogZmE489QVW
	z+xAgs1cNWFz4wJMcJ3oPmW7wUF4I4wy0itWEjPjqhEL0YaAlFr7NX4fGkHtC4dH
	69kvw4dKdo5hxhKGqsFc1Jtw3f9mwuY1pu+k=
Received: from localhost (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCkvCgDnLz5E_sNnUnzdBA--.12490S2;
	Sun, 02 Mar 2025 14:44:20 +0800 (CST)
From: adam_smystery@126.com
To: linux-kernel@vger.kernel.org
Cc: 
Subject: Hello! Rust is better than PHP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-CM-TRANSID:PCkvCgDnLz5E_sNnUnzdBA--.12490S2
Message-Id:<67C3FE44.0F01B8.16940@m16.mail.126.com>
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUq5x6UUUUU
Date: Sun, 2 Mar 2025 14:44:20 +0800 (CST)
X-CM-SenderInfo: 5dgdzspvp123xhu1qiyswou0bp/1tbifgMEumfD7erZngAAsn

Hello! Rust is better than PHP



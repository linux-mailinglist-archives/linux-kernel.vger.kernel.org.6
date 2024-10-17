Return-Path: <linux-kernel+bounces-369140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB6F89A1967
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 05:42:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09C391C2140C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 03:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94D7136658;
	Thu, 17 Oct 2024 03:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="THMJr+QN"
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A705B18641
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 03:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729136523; cv=none; b=LHe0TdvxNJ0LoUjp4w1zyeBVncKH3N/lHbUzrg4WRb1C3lduu50M+ft9BqG0PDWK5hXz7F89XGpZk1l4TSSUzd5voLPbh3AQTzKJgaALtPDpdZG8hZ0QXMOFJZyig59Xg9gBGS84fz+Nkvp/xKm6afLkcYozu0fBR2MAJYxiO3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729136523; c=relaxed/simple;
	bh=wPlAMLfWSW/brtvSdqSYccNCQDU82mpXKwvh3nOnEcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rdKq1cYGIg9OAFZEysfpDxeULacnzMVUNgsC7NX6PjzcQCR7I6hnOW9CV2PbaE6anCYV+dkLBp5trRmh3Bccym1gXtOOaNGzm+P/41fkjc/JLWEODiPPvoITzxtY/NZboLLTUxyrtos2DDl/mo9Z+VRZ54hbMtWULIaq8r9EBhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=THMJr+QN; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1729136449;
	bh=mFG/UR1tgaWQrb1thPhLyTJOgLJUtlqmvJbRhUqKawE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=THMJr+QNLcfdeBZFPqjYnFHAYJLXMSqDGUrs/UjMqX0KvGtNmqxIkDn+C8N3oklnP
	 fvOx2uyYDxxmG+0AzKtSG+9jy7dFxqwPYL6pG9kWAq9tlFkCp+8AgyXe5a9Nj9mEWI
	 PiZG5FphiG9zfjtkA4hhF4N399aDCLNaAriSRkD8=
X-QQ-mid: bizesmtpsz5t1729136409t8wnne6
X-QQ-Originating-IP: m+Yvnw1KaVX3h/G3pdOcoBdNO24x5FsuOsQNe7lHfR8=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 17 Oct 2024 11:40:07 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 3436797304957476087
From: WangYuli <wangyuli@uniontech.com>
To: helen.koike@collabora.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	wangyuli@uniontech.com,
	david.heidelberg@collabora.com
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	guanwentao@uniontech.com,
	zhanjun@uniontech.com
Subject: [RESEND. PATCH 1/5] drm/ci: Upgrade requirements because of bothering by GitHub Dependabot
Date: Thu, 17 Oct 2024 11:39:48 +0800
Message-ID: <11312D359DDCA3CF+20241017034004.113456-1-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: Mr/o/c6gDciS7Q71RM2V/GAWLofVA4RJ2ao5OVAfiTvg5nlMNmNSp0DC
	8PG1Lt3a3pYHPX9eskT5/YRURKx+Vnu+MvgqvSHzMJoAjtZnsCyyudaNrsmj5p7UaAn9Ata
	L+Rh6uAfXmMZ92GSRwE2p2VyWTEpD/uROL8tpi7S0EGLooIKzq5bgEIZx5SLA4K1HS/119G
	L9GhsVi+qlMpSry67swIRGmTcJrfD6Z0ig5X8Q9BOEwD6YlLmqS1j68PtNbHuenM3ZcVQTG
	JOjs8LyCOp/Dw93LN/o8Ee98vUV/b5hI/8HqPB/1HO55SdnDHXVyI0Xen0lwc8VE4ANCzvg
	cIvPoW2xnCWGjS/nbes+ZCIc3ffpMla9X1OqJWYXFmsSih2M/Xz5PNWt/MgoHLnmhuE7wkj
	NXZV4t8lvfD5ufQt4rbTWiQ8boaVTX7ypLj7grD3qxY6ZHK8/+C6RqTGfm88lUxcrDKFEBN
	hUVfGqFu4m6op+Q0kHv8JsVlVajEG7tT4UmNsQD9ERyQvyV5G8iitHzVUaFXle/OSMbUl+x
	thV2hIehrbfnlevU54yXs4uoOjUvmd8wQ3xMCoI0rhwTt05JmgTYRSH5siS9a/kK26PVBnC
	SV290wJNn76hNH15oHjKtAcNf2ZAAyO+xmfbW0P4gKKdmjPq2T0AakDy0mJPAtn05hHz14m
	Xf5qwDLXzHVHtCNuST0Ii2BsztnO9hdFlCfJnFg7IDlJb8CcdS5VbNuP9W8X2DmzEI8nhSr
	mD6yLVEl5r/9FlB0/aQBcaKCp6fodiJEhRUaYWc6ENKZLAusjXjgmH/1gI4cQBjaKiXSrS+
	fzFaRbZSoEOuCSTiNPvUJB3cevkcgp7TepMxcO9kTK7L3BpaFg9Csun+WDXhV8OLexzJQMs
	+1Vi+bZIZXU70601PQ63d3lT4232oqzT6xMZBP/DB9hnKQ1FmEFFBS7glufYr2k46ioMwbU
	+QHx+QFo6p7/EQq69Wo64l5s6TN4+UpZE6lZqfqdHIVLkt3aIsRgZznRPmQt0PMpdhMgJC9
	KfitvvxQ==
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0

GitHub Dependabot keeps bugging us about old, vulnerable Python packages.

Until we figure out a way to make it calm, we're stuck updating our
dependencies whenever it complains.

I guess it's a good thing in the long run, though, right?
Makes our CI a bit "more secure"...

Signed-off-by: WangYuli <wangyuli@uniontech.com>
-- 
2.45.2



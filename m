Return-Path: <linux-kernel+bounces-332663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA32F97BCC4
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 15:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92D331F2174F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 13:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FECE189BBB;
	Wed, 18 Sep 2024 13:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="CrXh+iPD"
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF24B1741C8
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 13:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726664870; cv=none; b=sb8fIM2nrB+1+n6S3sHqVDW5BiN0G5exdIF1XHEJ79KpIfBGbcZKK13mb8Y/8IXeG/yi5NYpFDLCDKigt3fJkoHan9FinRpfjieT2Dmj0FmuJf/lRCLRzooRyOf9gdgmxTVET+7kI1PlnTDIMdb3JILSX2BkZXJY+Ll+wF2T8x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726664870; c=relaxed/simple;
	bh=wPlAMLfWSW/brtvSdqSYccNCQDU82mpXKwvh3nOnEcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rBBZ0I6IcfFfpuZfQNfZVTQlMy2Fy+3S+M2CpVAPiu7yea+T2IIT7EfXntb3TjqLAwuRXgVMRjDYxcvvanxiVU3VF22JG9tXGBb8sYvUgQ/NBApO6jfjGQ9ua1gWfGzh/y0Zjwo3Pxib6nwqVQyR1h83WIhJx6eNJvsT7AbBsZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=CrXh+iPD; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1726664856;
	bh=mFG/UR1tgaWQrb1thPhLyTJOgLJUtlqmvJbRhUqKawE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=CrXh+iPDPP9S/GUz5t2qQFWzgOv+dA73QDJFQYguEf6u7zLX4xidLrSrKEZMB6MhG
	 5ORtkrxPPJU6foI61jBL2U05NuxEI+kEqtIznilGaxIsEqyrbIutyVx2oLsGmzEE+o
	 p1w9w8BR77gUZoQ89lFIQN39WRNLxVvrgiV/nPM0=
X-QQ-mid: bizesmtp89t1726664852tyi90m4h
X-QQ-Originating-IP: vyMhhsyf8qEGQcqP1YFb323COmReC+Tv/RxMZYxa3o8=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 18 Sep 2024 21:07:30 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 4378141738218118256
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
Subject: [PATCH 0/4] drm/ci: Upgrade requirements because of bothering by GitHub Dependabot
Date: Wed, 18 Sep 2024 21:06:39 +0800
Message-ID: <DDC5A709DAEC7F21+20240918130725.448656-1-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1

GitHub Dependabot keeps bugging us about old, vulnerable Python packages.

Until we figure out a way to make it calm, we're stuck updating our
dependencies whenever it complains.

I guess it's a good thing in the long run, though, right?
Makes our CI a bit "more secure"...

Signed-off-by: WangYuli <wangyuli@uniontech.com>
-- 
2.45.2



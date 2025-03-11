Return-Path: <linux-kernel+bounces-555810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB55A5BD14
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 11:01:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54A213AE84E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 10:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C386B233737;
	Tue, 11 Mar 2025 10:00:35 +0000 (UTC)
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4089822F389
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 10:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741687235; cv=none; b=SSrx8gujzjVLdt2sxDXUxBJSG5tsTHEAu9HOyN1Eb8Cu7wDuNMR+ge/mXAgdl/672nS6Ib+Q+K31OLYF4FKVNLTe/bg5T2T00iFhQGJy9iFCg2o7DpEkf46qJ5bdCec+gH7wvlnjD0Vks4ok+Uzn9jHFn6gGZSm2YAKdeG8T+Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741687235; c=relaxed/simple;
	bh=ZPEwqzWudHSJLpPww+0gDeglxepvNxQVsD7a4OJ5xBE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YS8FCyIxwbgYSXPqnXxD4/Qz3hYZ2QAyy07PjW5PestI4IWbnIP8tqp9Y1ntriijEWzXepOnr/qMG8I67izEjMrT80NyUv6oRcPXI7pN2sFVZeEXvK2kLpGZaJRStC0KUfwjoJVc3Npvpe+hQnqHLShfKzB7nRqQhLd9jssPZa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from localhost.localdomain (unknown [119.122.215.89])
	by smtp.qiye.163.com (Hmail) with ESMTP id de30fc18;
	Tue, 11 Mar 2025 18:00:20 +0800 (GMT+08:00)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: kever.yang@rock-chips.com
Cc: frank.wang@rock-chips.com,
	heiko@sntech.de,
	kishon@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	vkoul@kernel.org,
	Chukun Pan <amadeus@jmu.edu.cn>
Subject: Re: [PATCH 2/2] phy: rockchip: inno-usb2: add usb2 phy support for rk3562
Date: Tue, 11 Mar 2025 18:00:16 +0800
Message-Id: <20250311100016.841525-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241224094240.3817261-2-kever.yang@rock-chips.com>
References: <20241224094240.3817261-2-kever.yang@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCTkpPVkkfQ0xJGkpNGkMYTFYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlKSkJVSklJVUlKTlVDQllXWRYaDxIVHRRZQVlPS0hVSktJT09PS1VKS0tVS1
	kG
X-HM-Tid: 0a9584a5ea7403a2kunmde30fc18
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NhQ6Hgw*NjJNCBkeHwk1Ny4w
	LxwKCTZVSlVKTE9KTUNMSUlJS0xPVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUpK
	QlVKSUlVSUpOVUNCWVdZCAFZQU9ITDcG

Hi,

> This adds vbus detection function control and make the below tuning
> to enhance the usb2-phy SQ for RK3562 SoC.
>  - enable pre-emphasis during non-chirp phase
>  - set HS eye height to 425mv
>  - turn off differential receiver by default to save power

This is implemented by the rk3562_usb2phy_tuning function. Since
this is missing, I think the commit message needs to be changed.

Thanks,
Chukun

--
2.25.1



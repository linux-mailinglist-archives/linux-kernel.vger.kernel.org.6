Return-Path: <linux-kernel+bounces-332212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D305197B6D1
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 04:29:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55F07B26CBE
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 02:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A97610A1C;
	Wed, 18 Sep 2024 02:29:13 +0000 (UTC)
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8576B249F9;
	Wed, 18 Sep 2024 02:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726626553; cv=none; b=GbhefrfvOxCVSUZmUMHCa+MHqqWcMme1dFhqANNzF+t3nHn4bnM6uZHSX+le/m5BaeZeqv/lzWO832s1sjW+0b6MclbGouPA0To/FA31qJ/j3i6PbUDxWHoBDH2/xXHjIp7ClmajMVIfdBb47iiMNjwc0jKj3CXpkPGi2qZxnMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726626553; c=relaxed/simple;
	bh=R248A93YEAHzir1kVv21EEw6zizK4uMDm1sAWqEW/1I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d9RKNAIn4ysaCx63Bt6SIn6SwVuPH6Ty9vcn+jiaMX/NK0euW/bkPq5aYag9TlAGzeet1nuNCuxQcLba/kJP7tfTD1XWv7mBOg9yK7hovYcPnfTCSJOwJDgFN1AzKYEQAAKhBaPlT0fEyEOSQI/22yBgvKDjlaWftQ/y/mMxqlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from amadeus-Vostro-3710.lan (unknown [IPV6:240e:3b3:2c00:2bd0::1])
	by smtp.qiye.163.com (Hmail) with ESMTPA id B1ADE7E0149;
	Wed, 18 Sep 2024 10:20:08 +0800 (CST)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: bigfoot@classfun.cn
Cc: amadeus@jmu.edu.cn,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	dsimic@manjaro.org,
	heiko@sntech.de,
	jonas@kwiboo.se,
	krzk+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v3 3/3] arm64: dts: rockchip: add dts for Ariaboard Photonicat RK3568
Date: Wed, 18 Sep 2024 10:20:05 +0800
Message-Id: <20240918022005.487551-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <1a7d017a-8317-462b-8698-03cc7099a74f@classfun.cn>
References: <1a7d017a-8317-462b-8698-03cc7099a74f@classfun.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCSBpOVktCTE0ZQ08dSxpDGFYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlJT0seQUgZSEFJGEtLQUkZH0tBQUpZV1kWGg8SFR0UWUFZT0tIVUpLSUJDQ0
	xVSktLVUtZBg++
X-HM-Tid: 0a9202ee0f9b03a2kunmb1ade7e0149
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Pgw6Qzo4TDI5EQpMEjUQKigJ
	PgkwCSNVSlVKTElNTUlNS0tCTk5CVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUlP
	Sx5BSBlIQUkYS0tBSRkfS0FBSllXWQgBWUFKTktMNwY+

> I seem to have misunderstood the rules in dt-bindings before.
> The following looks better:

Please also update other regulators to unify the naming.

Thanks,
Chukun

-- 
2.25.1



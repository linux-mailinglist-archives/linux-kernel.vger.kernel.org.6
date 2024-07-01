Return-Path: <linux-kernel+bounces-236450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27BE891E282
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 16:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6DA1B27E66
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 14:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3739D168C32;
	Mon,  1 Jul 2024 14:31:12 +0000 (UTC)
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE1C15F408;
	Mon,  1 Jul 2024 14:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719844271; cv=none; b=qhCPJ4HeRgmqkZfSvEmf5r/EeH4vtwrb8HqwJmql+aTPJceqeww80AqwJKuowAnCkKYIO4zJqvSgV0b0d7P6oXRhZPANnaTSdLdNGP9+KyU6NoUa+CsQ5Z0DF2735AqEj0ScjfNfM4NKPOq3y8jqqde8iLW4RgH4XmbK6I8i7Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719844271; c=relaxed/simple;
	bh=Ny2hQasI3Mm2Jc2wi9rvvHCIXkgMdrGdN9aZDbHi4Ok=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HOWdgClZs546RF+nekD4gLr04mmLFdsEcPgsstc3hOrCDiFZl0cPfh3fzAbYbiXfnwJ7f4C/gKSx524nkkNbqOKKJSRtvaxn/ubFgE6MsPccs10f8bHKMzreVMkx1G1qbMo9YtBtC6apctUdqnXM21IxbTHWywPMGDBKNvM39KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from amadeus-Vostro-3710.lan (unknown [IPV6:240e:3b3:2c00:7a80:98d3:5fc8:a2a:615f])
	by smtp.qiye.163.com (Hmail) with ESMTPA id C109A7E0173;
	Mon,  1 Jul 2024 22:30:33 +0800 (CST)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: amadeus@jmu.edu.cn
Cc: conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	heiko@sntech.de,
	krzk+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	robh@kernel.org
Subject: [PATCH v2 0/9] arm64: dts: rockchip: fixes support for Lunzn Fastrhino R6xS
Date: Mon,  1 Jul 2024 22:30:25 +0800
Message-Id: <20240701143028.1203997-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240630150010.55729-1-amadeus@jmu.edu.cn>
References: <20240630150010.55729-1-amadeus@jmu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaSU5JVkwaGkwZGUNOGUgZHlYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlJT0seQUgZSEFJGEtLQUwaQ0tBQkMfSEFOHRhDQRpJGkFNSk4dWVdZFhoPEh
	UdFFlBWU9LSFVKS0lPT09LVUpLS1VLWQY+
X-HM-Tid: 0a906eb4630803a2kunmc109a7e0173
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Py46Pgw*DTNPFRdCFUI0TxUV
	Q1EwFA9VSlVKTEpCQ09PSUhPT0lCVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUlP
	Sx5BSBlIQUkYS0tBTBpDS0FCQx9IQU4dGENBGkkaQU1KTh1ZV1kIAVlBSkhLQjcG

Sorry for the noise, I don't know why some patches were not sent
successfully, so I resent them.

-- 
2.25.1



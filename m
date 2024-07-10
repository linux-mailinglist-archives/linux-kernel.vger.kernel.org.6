Return-Path: <linux-kernel+bounces-247762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05CB792D43B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 16:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9736284F4D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 14:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2CBB193467;
	Wed, 10 Jul 2024 14:30:59 +0000 (UTC)
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877D91863E;
	Wed, 10 Jul 2024 14:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720621859; cv=none; b=QmZpwCFHBADzFmVc3w5kZ+uSs0HVJtooSXoTYVPFsT4ZC+MXpx3AHpQ5kkgHoL4my8JTq9kw4hglmAvfHxzLBTt1ieZOIPBvhWsCGx8V5AsrfatUEHwiybCi++TBSyOdQ5Cnzn+QE9rR5cI4e7B+FcmfpOwtyoeOnQPeunybSW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720621859; c=relaxed/simple;
	bh=I09RG/0jIBH+sG3xXmW2m3nSscmDTI0K8QJvUWvHmeo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=T2N4abofom9arTMWaRW1iuGHe61HB+3BpMDB6vxq0RnFX2QAvidchDj/cpYFoHvxl4OX+CxBdNef8tnq6pphNQZvgWYxgXTf84F5Ers9FKCkWVO4R9rpHAlRhykC4JAKF+MdABxtBIyMc2GYVzMcrKw9eWH9tcOIwkm6iXhLlVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from amadeus-Vostro-3710.lan (unknown [IPV6:240e:3b3:2c00:fb60:82c0:6879:f4d2:caf4])
	by smtp.qiye.163.com (Hmail) with ESMTPA id EF9DC7E0116;
	Wed, 10 Jul 2024 22:30:34 +0800 (CST)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: Heiko Stuebner <heiko@sntech.de>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Chukun Pan <amadeus@jmu.edu.cn>
Subject: [PATCH v3 0/3] arm64: dts: rockchip: fixes support for Lunzn Fastrhino R6xS
Date: Wed, 10 Jul 2024 22:30:14 +0800
Message-Id: <20240710143017.685905-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCGUtCVklMHU1OHR9PSRpLQ1YeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlJT0seQUgZSEFJGEtLQR0ZTUtBQ0kYS0FNQ0xCQR1PH0lBGBodT1lXWRYaDx
	IVHRRZQVlPS0hVSktJT09PS1VKS0tVS1kG
X-HM-Tid: 0a909d0da3bb03a2kunmef9dc7e0116
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PzY6Kyo5SjI#FDAzPFY#PRdD
	EkpPCytVSlVKTElLTUlKQ0hOTUhOVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUlP
	Sx5BSBlIQUkYS0tBHRlNS0FDSRhLQU1DTEJBHU8fSUEYGh1PWVdZCAFZQUpNTks3Bg++

Changes in v3:
  Remove merged patches
  Further explanation of the PHY reset time changes

Changes in v2:
  Separate commits for regulator and supply changes
  Separate commits for R68S Ethernet PHY changes

Chukun Pan (3):
  arm64: dts: rockchip: use generic Ethernet PHY reset bindings for
    Lunzn Fastrhino R68S
  arm64: dts: rockchip: remove useless tx/rx_delay for Lunzn Fastrhino
    R68S
  arm64: dts: rockchip: Enable UHS-I SDR-50 for Lunzn FastRhino R66S

-- 
2.25.1



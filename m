Return-Path: <linux-kernel+bounces-225677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 799D891339C
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 14:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77B051F22FCC
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 12:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A95152782;
	Sat, 22 Jun 2024 12:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YXDWWtzi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329FF14D290;
	Sat, 22 Jun 2024 12:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719057605; cv=none; b=kav+J8Lyr9vzNeYUBwrWevyYavBTA+HMGBPkh/xUM5hvUJkmKRcr1uUBL0ByiOA6i61/xhqoZuah6REgcgChFxd6rwe8sCOFAqO/E4zIC6+gzwRxfrPZEd4oly2U6sHP3eY26gJLDNLlFWXeABP9CSW7B7ETEKuQg5nDBPJ8s2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719057605; c=relaxed/simple;
	bh=pyfgeu1JnckemJikNKhvTErMfifG8MGL945+/jEU6Xc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ar/567xrKrxm3S2Bti1GyCyqB0VLkv0Te3uL6Wh3eHHp9HhyYQBw1saC9cVzhCNqXgufqUimVcsCRpHjLxDnA66PgsKllMOBGsFmLs4L4tFAPocsCdNk2DO/iPvJXzsyTFDhvpBCvBqdHtWmo0AYrToqIV4MK1t1Bz8y61OsCuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YXDWWtzi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C10E6C3277B;
	Sat, 22 Jun 2024 12:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719057604;
	bh=pyfgeu1JnckemJikNKhvTErMfifG8MGL945+/jEU6Xc=;
	h=From:Subject:Date:To:Cc:From;
	b=YXDWWtzijQKAtZqCPg3hKl9q4wBXlYnOactGIvuq0VDMApyosX2s3zlaL2ZbGJN6a
	 lsDFB6RdfUMeN/V0DtTsvFjvCAhGQwgjoQVQWjZ2DzG/N14kyT6F021aGYmwbPCuah
	 Qz3GMhIYYE9jxaus/YPvINRb1Z8OUT2P5L4EIoCR+nZpYVyHFURKpWziTGN8tZSzZv
	 ITQOtOh6CvswsEbhGoqNzAzMacvXx88fL9ie/sR4D3gUxTQH+B/1tD1aLTyMvB9UPF
	 p31ED7CC4fiXN5OGIARlBqfR3bqQGTsJHHoCmYeinVwwOjDpHP6nDIqNLThVnRJezQ
	 jVno89mGiMbsA==
From: Roger Quadros <rogerq@kernel.org>
Subject: [PATCH 0/2] arm: dts: ti: k3-am62-lp-sk: Add NAND controller and
 overlay
Date: Sat, 22 Jun 2024 14:59:55 +0300
Message-Id: <20240622-am62lp-sk-nand-v1-0-caee496eaf42@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALu8dmYC/x3MwQpAQBCA4VfRnE2tiQmvIodlBxOWdktK3t3m+
 B3+/4EoQSVCmz0Q5NKoh08o8gzGxfpZUF0ykKHSMBHanWk7Ma7orXco7CrT1BMXPECKziCT3v+
 w69/3AzIdixpgAAAA
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Tero Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: srk@ti.com, praneeth@ti.com, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Roger Quadros <rogerq@kernel.org>, Nitin Yadav <n-yadav@ti.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=861; i=rogerq@kernel.org;
 h=from:subject:message-id; bh=pyfgeu1JnckemJikNKhvTErMfifG8MGL945+/jEU6Xc=;
 b=owEBbQKS/ZANAwAIAdJaa9O+djCTAcsmYgBmdrzBFrOPWhYLW766E7OaJD71Rxm0uol8ZkQ9B
 z0Lc7sQMvuJAjMEAAEIAB0WIQRBIWXUTJ9SeA+rEFjSWmvTvnYwkwUCZna8wQAKCRDSWmvTvnYw
 k7CAD/wJVnDzl6D62yI4jmXXpjEde1Bq9MCsdd+kvjQqThQnDlnWk3h9v4oH2VyhWXSbwIluVgR
 K22lVdXzGYnlNiZ0S890oxIIaf4/d+ZutN8AU0eiEviUoHGxuUE9YSS+iugmcUjglL1A0R8tL6Q
 +FM25JiwovH7HKfsK/7hWmT++bfKTAGLpi1Hdrme2Uhef5tIviww1OclJZljfWWHxJlqhjMnESf
 Z2sjg00ShDRLJVQ51zdG2l2m1ZmZqWmBfYi7E9Y2pXORNPJebphHTh+JRGFcOo4+Cd9b8MkeVOa
 ePMtgCLQYZ2gOYlxb9pcF145v7D9pwj2xxHIBj0Eg5E3WPU/giV8S/tupYEmbheX8uO0im8galR
 lUURK2IlX+sSXGgrFUC2GYgHdAHOj6EbmXF9vALwFG31yTsUhNxeLsif/vtFJpvXEsaeUYanBBP
 m2LcocIaiSI8wlfAViXTUuIs6F506Em3fxkNczJ8yWW0DxG2hZJ/ywuRQ7p3DIcBCb1Qo8TcuL4
 w/muEULKiSRseMVW70thCeKwK2bEFUbNhgMfhVowOYJCKrnGa8Hda8wL8519leQpsz3lXoXn/Ty
 LyHuOicjer77F6ZOdNycWTwfGvL8xTj9HFFEVc8W/qwiwZDY/qqmAQ8+owLAT8KDE4zFZmRYyUJ
 YS7qlNIOSon7O4g==
X-Developer-Key: i=rogerq@kernel.org; a=openpgp;
 fpr=412165D44C9F52780FAB1058D25A6BD3BE763093

Hi,

This series adds GPMC and ELM controller nodes to AM62 SoC.
It also adds NAND overlay file for AM62-LP-SK EVM.

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
Nitin Yadav (1):
      arm: dts: ti: k3-am62: Add GPMC and ELM nodes

Roger Quadros (1):
      arm64: dts: ti: am62-lp-sk: Add overlay for NAND expansion card

 arch/arm64/boot/dts/ti/Makefile                |   1 +
 arch/arm64/boot/dts/ti/k3-am62-lp-sk-nand.dtso | 116 +++++++++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts       |   4 +
 arch/arm64/boot/dts/ti/k3-am62-main.dtsi       |  29 +++++++
 arch/arm64/boot/dts/ti/k3-am62.dtsi            |   2 +
 5 files changed, 152 insertions(+)
---
base-commit: 4031a2866a9f0f5c585cfee65b3fb5ab17c95276
change-id: 20240622-am62lp-sk-nand-e6d5098f616b

Best regards,
-- 
Roger Quadros <rogerq@kernel.org>



Return-Path: <linux-kernel+bounces-336735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0DD1983FFF
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 10:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73D38286A5D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 08:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F20814A639;
	Tue, 24 Sep 2024 08:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deepcomputing-io.20200927.dkim.feishu.cn header.i=@deepcomputing-io.20200927.dkim.feishu.cn header.b="QcTt7vQm"
Received: from va-1-13.ptr.blmpb.com (va-1-13.ptr.blmpb.com [209.127.230.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E713E54FAD
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 08:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727165387; cv=none; b=F6L+5Ynd04s1xDzx9fKP1iyUmpASBHglTm92btqGPjn2AdMp7M1s3fx2GV7y0YHfoJOWI8UsOTCE2hs8ajxcEhWVJIZb0iTmTcO04Vdw1myhfSU9WtC/gy/0OgAFahXCXUI7sjkmlunJOKsbOlveiLSpBSEvvVgsbnEZ91FSDds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727165387; c=relaxed/simple;
	bh=8fuOhsqE58poSJHU8tPPKEkNAVTHiAEuT9/x8e/c7Gs=;
	h=From:Subject:Message-Id:Date:Cc:To:Mime-Version:Content-Type; b=rOqzLDe2AGvTkOVc1GPVbW1jnJZ5UYiXxhFnSa7zhSdsgci/xjdmD/1tCh1X9yYtLyzyymGMnp7ZKLdky7tUXxevwERYUVdG/gDaM7VAhDyuWuR4RuPfVh8M3krHI2iUa9BFjn60D6lxkYxYeydkiKp+g+HAFVzrxP3K19A8uDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=deepcomputing.io; spf=pass smtp.mailfrom=deepcomputing.io; dkim=pass (2048-bit key) header.d=deepcomputing-io.20200927.dkim.feishu.cn header.i=@deepcomputing-io.20200927.dkim.feishu.cn header.b=QcTt7vQm; arc=none smtp.client-ip=209.127.230.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=deepcomputing.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deepcomputing.io
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=deepcomputing-io.20200927.dkim.feishu.cn; t=1727165239;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=vGD1AH3YX//UwvtNlpt8F40Wl2KLWAnFu9Se/h7rMAI=;
 b=QcTt7vQml+nJQeObXcr2SiEvNzz60xWUTn+PX4T+IJHZzFI9Wal9qWee2xmvXTVeZy7FbU
 boQveQisac1jAsTRuy+CnAqfd65WGomGIX45PdAE+FDgpiUGZoV+H8+GKbnbBN99hLnsDJ
 LbIzaVcTwkPXDCFXse/OK1DixVf9sQMRDzAuqi5wn2uDUOxE1eza8o6GEhdO3V0uTIF4NB
 w5zqtc58On0tLkXPn+uX2NIAumyX0xCGwB5BONspctsV+KblRDJVkSmH4ph7LGqHydcvP9
 rsU1v8IXCOCqHfwdLWeLKe7Mps9cq93tK0qoL/8lgc/WybRDhLS8GoSiXbBUkA==
From: "Sandie Cao" <sandie.cao@deepcomputing.io>
Subject: [patch v2 0/3] Add Framework FRANME0000 dts
Message-Id: <20240924080650.1345485-1-sandie.cao@deepcomputing.io>
X-Mailer: git-send-email 2.34.1
Date: Tue, 24 Sep 2024 16:06:47 +0800
Content-Transfer-Encoding: 7bit
X-Lms-Return-Path: <lba+266f27337+026eff+vger.kernel.org+sandie.cao@deepcomputing.io>
Cc: "Emil Renner Berthing" <kernel@esmil.dk>, 
	"Rob Herring" <robh@kernel.org>, 
	"Krzysztof Kozlowski" <krzk+dt@kernel.org>, 
	"Paul Walmsley" <paul.walmsley@sifive.com>, 
	"Palmer Dabbelt" <palmer@dabbelt.com>, 
	"Albert Ou" <aou@eecs.berkeley.edu>, 
	"Heiko Stuebner" <heiko.stuebner@cherry.de>, 
	"Neil Armstrong" <neil.armstrong@linaro.org>, <rafal@milecki.pl>, 
	"Linus Walleij" <linus.walleij@linaro.org>, 
	"Michael Zhu" <michael.zhu@starfivetech.com>, 
	"Drew Fustini" <drew@beagleboard.org>, <linux-riscv@lists.infradead.org>, 
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	<dhs@frame.work>, <ams@frame.work>, <gregkh@linuxfoundation.org>, 
	<yuning.liang@deepcomputing.io>, <huiming.qiu@deepcomputing.io>, 
	"Sandie Cao" <sandie.cao@deepcomputing.io>
To: "Conor Dooley" <conor@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Original-From: Sandie Cao <sandie.cao@deepcomputing.io>
Received: from roma-MacBookPro.. ([61.141.249.39]) by smtp.feishu.cn with ESMTPS; Tue, 24 Sep 2024 16:07:18 +0800
Content-Type: text/plain; charset=UTF-8

DeepComputing is creating a RISC-V Framework Laptop 13 Mainboard 
powered by a StarFive JH7110 processor.This is a developer-focused 
product, aimed at making tinkering with RISC-V more accessible.
The Mainboard is under development and we'll share more on functionality, 
compatibility, and availability as the program progresses.

Framework Model: Framework FRANME0000
DeepComputing Model: DeepComputing fm7110

V1:
- Add framework dts and config.

V2:
- Add deepcomputing into vendor list.
- Add deepcomputing,fm7110 into model compatible list. 
- Fix the error about dtbs_check.
- Framework Config will be included in later patch.

Sandie Cao (3):
  dt-bindings: vendor: add deepcomputing
  dt-bindings: riscv: starfive: add 
  riscv: dts: starfive: add framework dts

 .../devicetree/bindings/riscv/starfive.yaml   |  1 +
 .../devicetree/bindings/vendor-prefixes.yaml  |  2 ++
 arch/riscv/boot/dts/starfive/Makefile         |  1 +
 .../boot/dts/starfive/jh7110-framework.dts    | 34 +++++++++++++++++++
 4 files changed, 38 insertions(+)
 create mode 100644 arch/riscv/boot/dts/starfive/jh7110-framework.dts


base-commit: abf2050f51fdca0fd146388f83cddd95a57a008d
-- 
2.34.1


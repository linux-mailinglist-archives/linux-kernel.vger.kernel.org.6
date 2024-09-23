Return-Path: <linux-kernel+bounces-335435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1391B97E5B6
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 07:49:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C785C281513
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 05:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47CBF11185;
	Mon, 23 Sep 2024 05:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deepcomputing-io.20200927.dkim.feishu.cn header.i=@deepcomputing-io.20200927.dkim.feishu.cn header.b="qXHU7v8a"
Received: from lf-2-40.ptr.blmpb.com (lf-2-40.ptr.blmpb.com [101.36.218.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A81D134B2
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 05:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.36.218.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727070542; cv=none; b=kiYgUnXyvYF+/7Le78TzBI5EqgWSU6uZJN8inDXmnjiFcUKiQ119Uo5TbpcVHHZz6oUu6aJUmMZJiwTSgOfocYcNicZ8OjHI8/f6vj1knpn0EQLYNENKZmudqEN/9qaRJ0QcdbhVxEAWvOtrD5bucLKO/bgOU2BdpaTk4awDxwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727070542; c=relaxed/simple;
	bh=/ghcqLauH0+CMXorpxpw/GTZdb/NnVf+X3CD68EoTEk=;
	h=Cc:Subject:To:Message-Id:Mime-Version:Date:Content-Type:From; b=PGF6KWmheGBew3cZX6J78dO9Gkfjj3oJBX73uldy40tTl636hl6OPnhYIrH8gYRCpN8C2UYYwmjmU5GBjhOAoz/M5fKVmGW1zOh6jPPLYjiL9yYXtDUglFwET7vCqW9PJjRDY+9t5LLDwav+pZB/aSJ47lAqszPShuPM0JWorg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=deepcomputing.io; spf=pass smtp.mailfrom=deepcomputing.io; dkim=pass (2048-bit key) header.d=deepcomputing-io.20200927.dkim.feishu.cn header.i=@deepcomputing-io.20200927.dkim.feishu.cn header.b=qXHU7v8a; arc=none smtp.client-ip=101.36.218.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=deepcomputing.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deepcomputing.io
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=deepcomputing-io.20200927.dkim.feishu.cn; t=1727069788;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=aV6BkKf5lBk9jyifuv+6J+XRGBiA2WnxkCA2SCxaiWI=;
 b=qXHU7v8agvU3Rz1J+NXGp7NSek8bhPkhXB0K3AMKbZSL0y/b/9YtK9mi/GmC8eFH2EZXUZ
 IT+ut3DVKy3pk74W9D9ICdiMbsDysR8V+slccj7S4zLdFoBb4Oho4b6WI7Tg8wwWHys2hP
 jcjzraRm00X7PEwIoiiMu7PfoEuiaq/0tz/+64hN32WtqZdi8ViqylnqOqCJiXo8dUzayn
 aF3VhmDjAdIuaZSK28GLOE3NLRIFscncxEVvDfvkPIOEfzHtdDsA8GjF0ksCcjzeGNErsC
 fFUxrnvApM2Ne3jdrr1wensxd6mC0ppyA9XfxfnWfO4/zMT/jtT34Tpv5nMyUw==
Cc: "Conor Dooley" <conor@kernel.org>, "Rob Herring" <robh@kernel.org>, 
	"Krzysztof Kozlowski" <krzk+dt@kernel.org>, 
	"Paul Walmsley" <paul.walmsley@sifive.com>, 
	"Palmer Dabbelt" <palmer@dabbelt.com>, 
	"Albert Ou" <aou@eecs.berkeley.edu>, <linux-riscv@lists.infradead.org>, 
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	"Sandie Cao" <sandie.cao@deepcomputing.io>
Subject: [PATCH 0/2] add framework dts and config
X-Original-From: Sandie Cao <sandie.cao@deepcomputing.io>
X-Mailer: git-send-email 2.34.1
X-Lms-Return-Path: <lba+266f0fe5b+20bb59+vger.kernel.org+sandie.cao@deepcomputing.io>
To: "Emil Renner Berthing" <kernel@esmil.dk>
Message-Id: <20240923053621.1585972-1-sandie.cao@deepcomputing.io>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Mon, 23 Sep 2024 13:36:19 +0800
Received: from roma-MacBookPro.. ([61.141.249.188]) by smtp.feishu.cn with ESMTPS; Mon, 23 Sep 2024 13:36:26 +0800
Content-Type: text/plain; charset=UTF-8
From: "Sandie Cao" <sandie.cao@deepcomputing.io>
Content-Transfer-Encoding: 7bit

Add  dts and config to support RISC-V Framework Laptop 13 Mainboard. 
https://frame.work/products/deep-computing-risc-v-mainboard

Sandie Cao (2):
  riscv:dts:starfive:add framework dts
  riscv:configs:starfive:add framework config

 arch/riscv/boot/dts/starfive/Makefile         |   1 +
 .../boot/dts/starfive/jh7110-framework.dts    |  35 ++++
 .../starfive_jh7110_framework_defconfig       | 151 ++++++++++++++++++
 3 files changed, 187 insertions(+)
 create mode 100644 arch/riscv/boot/dts/starfive/jh7110-framework.dts
 create mode 100644 arch/riscv/configs/starfive_jh7110_framework_defconfig


base-commit: de5cb0dcb74c294ec527eddfe5094acfdb21ff21
-- 
2.34.1


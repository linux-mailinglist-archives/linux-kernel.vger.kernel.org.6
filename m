Return-Path: <linux-kernel+bounces-223136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C3D910E4F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 19:19:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EE9F1C21FFB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 17:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 995891B3F3B;
	Thu, 20 Jun 2024 17:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PdcfotoP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29AE1ABCB1
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 17:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718903964; cv=none; b=Mwvv5M6wJzrFQ2PYjasXmI9Drb4goYnx06MQb/iUKoRqPGe3cHFe7ACGx9tEtR64nhh+7J/s4KLMhKtDO7eKAJ7frsIStm+TQVJSgaCJivJdM4+UAkP+MHruakXrt1uvMqPz6O18fznnjYuc71nQf0iDkmkea2o1+0wI5m3fMzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718903964; c=relaxed/simple;
	bh=zBfG+EjJUTXji9w85aJFYIKQcQax5Gx95XV860fIzyc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=BT1YzdV/T0sl7XRk3toS/GEqQ0gjx8I6uEZNxO4TTnsZmKI5LyallqLDRMpwXcJSMxyEkIoD5lwEf9aRKtPiqoaHXBdr6gZ0VU4uKtzUmFa7cIauOCj5X77r1ujihY7jHfgShwEfsZvjD4qanh54mFWMgGNcBo+S3IydMD7Jm1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PdcfotoP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9681AC2BD10;
	Thu, 20 Jun 2024 17:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718903963;
	bh=zBfG+EjJUTXji9w85aJFYIKQcQax5Gx95XV860fIzyc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=PdcfotoPT/MCbkXLW/K1QG7veCOhl4PGtoUFQSETZ9X++P+gv0puVEjmCYXRp91/g
	 RzhN9xEBl73dmNtstVokja504UzzO9tUD0e+OoHXGK72wdnziiwUPCeGvKTVdaHhR0
	 EK+Qn65ciEeO+rYDUNSY5S8rYCb4e/jk6OiwDdwaLjYTAYnvI9QbPNO9tMorafRqFB
	 k7juGBZ3SHUu7ylX/Ya/kt2HBMAA0S3W3jYVdF39ycG/fc2ZSJ6njrLAZn1V6T6o97
	 2gewMidm93SMcd/LEeq4kxvx7GTUztPIsdX921wBWCZye7ZfKuRXzbcwDXcl9fTlbd
	 xNzZ5rnMNILRQ==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org, Yang Li <yang.lee@linux.alibaba.com>
Cc: linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
In-Reply-To: <20240618011854.109426-1-yang.lee@linux.alibaba.com>
References: <20240618011854.109426-1-yang.lee@linux.alibaba.com>
Subject: Re: (subset) [PATCH -next] mfd: tps6594-core: Remove unneeded
 semicolon
Message-Id: <171890396233.1312486.14895407266308204826.b4-ty@kernel.org>
Date: Thu, 20 Jun 2024 18:19:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13.0

On Tue, 18 Jun 2024 09:18:54 +0800, Yang Li wrote:
> ./drivers/mfd/tps6594-core.c:516:2-3: Unneeded semicolon
> 
> 

Applied, thanks!

[1/1] mfd: tps6594-core: Remove unneeded semicolon
      commit: 7bc1d9ffae4d414081308ba1cec0d8d520c80cfb

--
Lee Jones [李琼斯]



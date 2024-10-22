Return-Path: <linux-kernel+bounces-375638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91CF49A9880
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 07:33:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E0D11F23C01
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 05:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF06913C8F4;
	Tue, 22 Oct 2024 05:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j1eVMsHr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E8F139566;
	Tue, 22 Oct 2024 05:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729575148; cv=none; b=iDWcKZ0XZsZJoNeyFAKX4a7Y11L9mwgE/6YQyWhN65Hdh//BkOMkOtapeftt6Lg9X4iW+BbLhmaB8rHdx6JeyeKpY/BH0MKpuweMCt3PiKviq+359E+1zJnifWYrccNkMjS4MPGwZ12f6vnKRXt9ldsjxqtjMAiTjm6T0xrFSgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729575148; c=relaxed/simple;
	bh=H/fnf6f8qWM0l7nfUX7YQ+kJ3euoRzwtgYvKc7YmD7Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ecYnZriOHF7pfn8WscWjY7IOjfPhNbCXc/MCibN6VbE3nyy+++xXy8eUS1BBzVhevMdf2encsBuMtYXD5Yso2SZT3gz3M6Ych37CNgiTqLgrH1AErC8G4VQpuuIJXa7T2WTR75YsPEpmInzyxW8V7hlqN+Vjd7aeEJpMYxTExWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j1eVMsHr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0663FC4CEE7;
	Tue, 22 Oct 2024 05:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729575147;
	bh=H/fnf6f8qWM0l7nfUX7YQ+kJ3euoRzwtgYvKc7YmD7Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=j1eVMsHrrvPHO9QH70PqlSwBzrBkOuM898guN7cm3+O586sdjSSCUWFa1ivvs2dA7
	 5vBs6kc5g8lE7ou4Hs0sGGJUFk19K7iNQMSSF0/V/1/FDUvGxIkIpebc9JwfQ0qrXJ
	 5mAqA2GBi8CVWBEi9FNDx7P7e8KdjQ8rk7FdznQKCgc3NBVStrnM6FK57BxDOyY1zG
	 btaQUSJRN27WuY2caESWsLn0/+7rNeJDOEhJ0+DH2TiQGD69/bCzlAukDHv11Fu6LE
	 5qgJ5C9bvoinPQjMhogh28t09AhlPeT6lZvsTKv5JgRY6YD/pztWwSH+dsfPWArXxn
	 ofN6s8NPYlPTQ==
From: Vinod Koul <vkoul@kernel.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>, linux-phy@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>
In-Reply-To: <20240913044557.28315-1-zajec5@gmail.com>
References: <20240913044557.28315-1-zajec5@gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: phy: bcm-ns-usb2-phy: drop deprecated
 variant
Message-Id: <172957514491.488852.7301483623512252577.b4-ty@kernel.org>
Date: Tue, 22 Oct 2024 11:02:24 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.2


On Fri, 13 Sep 2024 06:45:56 +0200, Rafał Miłecki wrote:
> The old binding variant (the one covering whole DMU block) was
> deprecated 3 years ago. Linux kernel was warning when using it for
> similar amount of time.
> 
> There aren't any known Northstar devices with bootloader providing DT to
> operating system. Actually OpenWrt seems to be the only project using
> this binding and it always appends DTB to kernel. It has switched to the
> non-deprecated binding years ago.
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: phy: bcm-ns-usb2-phy: drop deprecated variant
      commit: c3639d423d76c935b58827296a124e8f13d79b4b
[2/2] phy: bcm-ns-usb2: drop support for old binding variant
      commit: 0175a673e478eed99a86fc094e7d91ed2f3d5a34

Best regards,
-- 
~Vinod




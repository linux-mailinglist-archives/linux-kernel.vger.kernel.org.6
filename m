Return-Path: <linux-kernel+bounces-353742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E1D49931FD
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 17:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5A87B265AB
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 15:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ED221DB373;
	Mon,  7 Oct 2024 15:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eLCBPb2B"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC81A1DB350;
	Mon,  7 Oct 2024 15:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728316144; cv=none; b=nbpTjb0bHiI1MhJepxZikX1jv4DhuDOOjBuQAzujA0Psu/rHxCdGUUpAuVLKLVuYn+LcPOuQ+pnjNAgyiEVvmJlrRsqjciPDINWWMHFemimycqyajvsg154VxdVOCof1x9pUyPQLMEaHTxn3DAHp3v4HyrhRSdbjTuYbfUQKV3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728316144; c=relaxed/simple;
	bh=fdQgCvkUVNcWgqqhdAJ2FjLhihD1asnc+B1Iuh/DpfY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=hjEr7wh125JzNhGJj9OdA8cAwJbPkBW5Aj2FEyhUlmzVtUZoDCMrP/+3DzdT+fG7Tvkk9KaTxy/Lfq49VrzQlm7pCcOz+DOdjfC8Bfev6gEYPk5fzGyVwzM5YIpDz72Q0VV8oalXlJUxnVKLypSjto4x/oyh182ttHL5QQnqShg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eLCBPb2B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7203C4CED0;
	Mon,  7 Oct 2024 15:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728316144;
	bh=fdQgCvkUVNcWgqqhdAJ2FjLhihD1asnc+B1Iuh/DpfY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=eLCBPb2Bfjd7B77CLVW4dY4aML/1Dwpq2AAxtMwfOaXWvlhfURh/YmDhXXP7C308J
	 SOpjm2zRTcJiWo3ffieH1BQK6H2j1t6Ze8qJodEhZ03tgtRHnwVkbaIBZELYOzPkF6
	 HP9fVq5LBsDneoPT0gQ5s0f0YNbdE4ou1wfZnyoWiTAVJ9j9aVVN8jnjp0R+Dk6r0H
	 OJmxhB+zvA6u6mOv+fgGWMZUZbsrsXWAzfU3rlWK+q8sYHvk7uUWEteho1wOoYTrZ8
	 E5u2p1XKXHLLnlgccfoFw66LLUDJT6vf291tjTyEaEaK6xXV7tPyLfrFSrlk8QJQpi
	 Jv7NVoFbIu3hw==
From: Vinod Koul <vkoul@kernel.org>
To: kishon@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, mcoquelin.stm32@gmail.com, 
 alexandre.torgue@foss.st.com, p.zabel@pengutronix.de, 
 Christian Bruel <christian.bruel@foss.st.com>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 fabrice.gasnier@foss.st.com
In-Reply-To: <20240930170847.948779-1-christian.bruel@foss.st.com>
References: <20240930170847.948779-1-christian.bruel@foss.st.com>
Subject: Re: (subset) [PATCH v9 0/5] Add STM32MP25 USB3/PCIE COMBOPHY
 driver
Message-Id: <172831614044.134526.10151258840417457919.b4-ty@kernel.org>
Date: Mon, 07 Oct 2024 21:19:00 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Mon, 30 Sep 2024 19:08:42 +0200, Christian Bruel wrote:
> Changes in v9:
>    - Fix bot clang warnings: uninitialized variables and
>      include bitfield.h for FIELD_GET
> 
> Changes in v7/v8:
>    - MAINTAINERS: Reorder STM32MP25 DRIVER entry
> 
> [...]

Applied, thanks!

[1/5] dt-bindings: phy: Add STM32MP25 COMBOPHY bindings
      commit: 8c7e955fac07ee11c76ddf2330587fe083fab1a2
[2/5] phy: stm32: Add support for STM32MP25 COMBOPHY.
      commit: 47e1bb6b4ba0987139ab790efa03c542ebc1b10d
[3/5] MAINTAINERS: add entry for ST STM32MP25 COMBOPHY driver
      commit: b6a713b92ebb9e7ee1495f009fd02a71e485184f

Best regards,
-- 
~Vinod




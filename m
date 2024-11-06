Return-Path: <linux-kernel+bounces-397863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 505E49BE18D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 10:03:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F26311F232E4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 09:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C601D63EF;
	Wed,  6 Nov 2024 09:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BTsAUEvS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61466149E00
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 09:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730883783; cv=none; b=szEVCaggbsSqJ85lqZZmRIkmPPZZcbZiRTtTyAu7iE4y6h9qGjTqAjAcVzRdk7kTzsZsDfdf1Np4YxOVwE2J4P/UM8guTKt3K8oxBOtADh1LJ1LoJwoca7IgTYxFlyj0yYmt2gW6NmJYDW/sjsrHvX6w4JO7LMav0zGoPnN2aYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730883783; c=relaxed/simple;
	bh=GGYya4V0Tfm9xp25115PJamZA8omvJIZFwUloqzc2WU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=oXtIqlhvKZuctZW3fDt7svHGn/APDsyK3dfvFybHwISx69YlhfrnqOzmEGe7CSALX53efO0mb/rJlInfIF7gXgG1jBqHBnHnQs9ZBZGQOp8D71fs5sLK1htF1oFJvpPeMQzbmouVN8Lrja4ZzVegLgiMYYL1f3sguszutbDvRMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BTsAUEvS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08A0EC4CECD;
	Wed,  6 Nov 2024 09:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730883782;
	bh=GGYya4V0Tfm9xp25115PJamZA8omvJIZFwUloqzc2WU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=BTsAUEvSfPyLECakun2AQc2bVUukCUCXReNiu/St/cHKf7kEb4WOcddmSDzp9Jx+l
	 40gJdxHKp9PeaMLNWeQ64bFWyd/m+wvhbLbGOxvQtdWX24TgVYIj5AnfLHdawZ0Rx0
	 Yu22B4LrOUcJgK0x3jT42oTfxfOVcYWTMJifmDvvKcXixpH6eK+PILajDsMPKdCh2g
	 2iARQGyw+JsKCbZyLQVdjoJQ5VIeZ8HKDIoab/DQt5JwLTtz0Qrve/a/c7u1vk5Ucy
	 SzmOfQvtwVQ+B1wJjKSih6DBTFc2NLQ2Tpbfo4PtauVEkQT6m5COPuFSoO5r1VGOPm
	 RlMy/ZscNVuFw==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, Andy Shevchenko <andy@kernel.org>, 
 Hans de Goede <hdegoede@redhat.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20241104150655.41402-1-hdegoede@redhat.com>
References: <20241104150655.41402-1-hdegoede@redhat.com>
Subject: Re: [PATCH v2 0/2] mfd: intel_soc_pmic_crc: Add support for non
 ACPI instantiated i2c_client
Message-Id: <173088378173.3265250.3240175221915182986.b4-ty@kernel.org>
Date: Wed, 06 Nov 2024 09:03:01 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13.0

On Mon, 04 Nov 2024 16:06:53 +0100, Hans de Goede wrote:
> Here is v2 of my series to add support for non ACPI instantiated
> i2c_client-s to intel_soc_pmic_crc.
> 
> Changes in v2:
> - Consistently use the filename as driver name for all intel_soc_pmic_*
>   drivers
> - Use "intel_soc_pmic_crc" as i2c_device_id.name
> 
> [...]

Applied, thanks!

[1/2] mfd: intel_soc_pmic_*: Consistently use filename as driver name
      commit: c3768c474830fab0fa3063e72dd005eb6cef0618
[2/2] mfd: intel_soc_pmic_crc: Add support for non ACPI instantiated i2c_client
      commit: bd302f82be1e10a1395d58d405e0e8af049d1cc3

--
Lee Jones [李琼斯]



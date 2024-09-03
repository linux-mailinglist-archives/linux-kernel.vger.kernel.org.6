Return-Path: <linux-kernel+bounces-312929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C2F969DDA
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 14:40:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72A952828B4
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 12:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DEA41D86DF;
	Tue,  3 Sep 2024 12:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="oz5rgpGT"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50AB21D0973
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 12:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725367149; cv=none; b=MvlKVE1bEcfktFwfoVQE7rFhVZYWGMytuklO2nwGykChr7pp5Mxu+u+tLjkh3NLxB1kkgWSnbvMEQ/8wUowZt9UgxunWPb/d9l+fuRxaepwogXMKurLljjMqx/EB5HQF6qeDDSDQgxqVydQWD0CHqN/Sj0y5xj7eB6Lb9WnA4s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725367149; c=relaxed/simple;
	bh=9EUgh/iRZYIKo8L1TrwG0qkrKsHg5u2Gwl+yqsTn8eY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nQEGXNrQGgE52CdbT3uiPmIEQdhbUaZ2U0eIWaOPXwCeZsE3D+TdnLsZ4yfLKyLKpAnd93yuHS2Sn1V1+isOgMbarML/mHCqJc0yfq2hmCQdNedf0PvmEjYDKbRzlKZUYFJVc61ExufsEV4zPGOdgEW/VvMSH9ANeBqpN8iqzs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=oz5rgpGT; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1F1BAFF803;
	Tue,  3 Sep 2024 12:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1725367144;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WdR7Hkho7vZns/e/ivFcBa7d3lCrHmWRkNnZTJO/YrU=;
	b=oz5rgpGT1uoPgf6EaUY1rEDKFKF0/dFjgYkvIlRxlR4a3CVjnu97LkwEeaISbemhIgRApH
	itxnghcqKJtmEZar8142R9Sk1bJee04oWvW+l55HSzatfb54jMb9KYIRJ4ALHSkHekEleO
	882HLKNES6FBqw4pcb4iQnyiXhkZJm78wL+gtejaa7VXSzPgJIzSDeFTznSQ/sEHodM5JZ
	VFU1vF1cmR4MArW4G09gD0CoM/FunMT4cGGUJAh7pvq26Mc8UL5bNLDSUg5+2X/c6qNyBq
	MZ9gEQzJVxCIH8HkmatDtTNR3HL9t6jVyIqCDfS8/C1Ctrnp0h7LkUvhceS8/w==
Message-ID: <32351be6-d08c-4b4d-a4a6-a75066689ccb@bootlin.com>
Date: Tue, 3 Sep 2024 14:39:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Add resume support for the mux mmio driver
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, gregory.clement@bootlin.com,
 theo.lebrun@bootlin.com, thomas.petazzoni@bootlin.com, u-kumar1@ti.com,
 Peter Rosin <peda@axentia.se>
References: <20240613-mux-mmio-resume-support-v1-0-4525bf56024a@bootlin.com>
Content-Language: en-US
From: Thomas Richard <thomas.richard@bootlin.com>
In-Reply-To: <20240613-mux-mmio-resume-support-v1-0-4525bf56024a@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: thomas.richard@bootlin.com

On 6/13/24 15:07, Thomas Richard wrote:
> The patches of this series were originally in the series "Add suspend to
> ram support for PCIe on J7200" [1].
> There is no changes compared to the patches in the series [1].
> 
> These patches add resume support for the mmio driver.
> The first patch adds a new function mux_chip_resume() in the mux subsystem.
> The second patch adds the resume support for the mmio driver using this new
> function.
> 
> [1] https://lore.kernel.org/all/20240102-j7200-pcie-s2r-v6-0-4656ef6e6d66@bootlin.com/

Hello maintainers!

There is no remaining comments to address since a log time for this series.
Is there any chance to get this series merged ?

Thanks,

Thomas

> 
> Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
> ---
> Thomas Richard (1):
>       mux: add mux_chip_resume() function
> 
> Théo Lebrun (1):
>       mux: mmio: add resume support
> 
>  drivers/mux/core.c         | 29 +++++++++++++++++++++++++++++
>  drivers/mux/mmio.c         | 12 ++++++++++++
>  include/linux/mux/driver.h |  1 +
>  3 files changed, 42 insertions(+)
> ---
> base-commit: 8e7767d07e04b89999d5adefb190f4d5e566d8d4
> change-id: 20240613-mux-mmio-resume-support-4f3b2a34a32a
> 
> Best regards,




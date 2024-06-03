Return-Path: <linux-kernel+bounces-199147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D7F8D8303
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 14:56:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EE281F22C70
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 12:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EFE412C554;
	Mon,  3 Jun 2024 12:56:46 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C2A212C482
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 12:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717419405; cv=none; b=QvgDluo41NLZ6QCt3Q6xrSD2UbAJbfkXLuZpila/GXnw7l+cAXlhidwHeP4MJ5iv5tjxQDIgGRTZ4K3PoEsuO6RMWjby61ibuA8u9pjaFFFGhGX/1Uq089J5xbMdovYRVhF0kbfI66Gch0VrDZh7jYLI9wLE0IrBiyOSPi9A8rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717419405; c=relaxed/simple;
	bh=l3eSi6NlZlz5bF1blVV/ATRpnxs0oZeHaZkI7au8cPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZyK/BVHfEiLLsng0iMjsn2qmp4GzR9nQH2QNfB4RP5pjhicX/WYT3L0UBxpZiU43ohEbCR5SNqHWCcRekujAelzxm5XejV+a8tARfg5L7Xvb8D1y9h82RaSJqY8UAgEoy28pPiAtcNV+3VujoNUMXcNRxPmEq9ZUdpEsxR0n1g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E90391063;
	Mon,  3 Jun 2024 05:57:07 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 993463F64C;
	Mon,  3 Jun 2024 05:56:42 -0700 (PDT)
Date: Mon, 3 Jun 2024 13:56:40 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Russell King <linux@armlinux.org.uk>, Liviu Dudau <liviu.dudau@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	"Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] arm: vexpress: Remove obsolete RTSM DCSCB support
Message-ID: <Zl29iCHMp4Y2PY8z@bogus>
References: <20240510123238.3904779-1-robh@kernel.org>
 <171576525046.1945769.9546905970570452026.b4-ty@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171576525046.1945769.9546905970570452026.b4-ty@arm.com>

On Wed, May 15, 2024 at 10:30:07AM +0100, Sudeep Holla wrote:
> On Fri, 10 May 2024 07:32:35 -0500, Rob Herring (Arm) wrote:
> > The Arm Versatile DCSCB support is unused as the compatible
> > "arm,rtsm,dcscb" is unused in any .dts file. It was only ever
> > implemented on a s/w model (RTSM).
> >
>
> Applied to sudeep.holla/linux (for-next/vexpress/updates), thanks!
>

I have now rebased as it couldn't make it to v6.10-rc1 just for simplicity
(could have merged v6.10-rc1 though)

[1/2] arm: vexpress: Remove obsolete RTSM DCSCB support
      https://git.kernel.org/sudeep.holla/c/eb3f614ae482
[2/2] dt-bindings: arm: Remove obsolete RTSM DCSCB binding
      https://git.kernel.org/sudeep.holla/c/32b0cf0379b6

--
Regards,
Sudeep


Return-Path: <linux-kernel+bounces-198349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E2B8D770A
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 18:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9FD11F218F6
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 16:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E644DA00;
	Sun,  2 Jun 2024 16:00:27 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001DE4C634;
	Sun,  2 Jun 2024 16:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717344026; cv=none; b=BTBGjhANWLECVRX21L5zslukf7tkdCL2g3n8z5N954cmFNQkqM5SH7V44QKng/vqG9ijysTVPwhvwLZv1ZBKy3mz1W8aNFqqvQQvJeWEc7UT+gTQAhm7+plPJADtRnRyEl+hiUNl54YhwF+/FFK0tkdRuxJ2DkzPBwcPyhsRh5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717344026; c=relaxed/simple;
	bh=4Fmn4crQtRf3YiAQzPeyl27r+OK3btqW3qYBulXNoFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fLPNmbPkFs6tiw1KQyo5lYv4ZuQhBzk8UzhdHQ9trLQ+SebwVkesRk8cANUivPARR2sLjKrOb3iQaI2cF47FYafiqUuF7xN8aZOe59LLPA8SGc3cpWjE6dKZutJg4u7SKS8rrp6f76bGDq9+n32NepjoeiPjUW/YdFyNeNFpFtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5F2B5113E;
	Sun,  2 Jun 2024 09:00:48 -0700 (PDT)
Received: from bogus (unknown [10.57.83.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D1BDC3F792;
	Sun,  2 Jun 2024 09:00:21 -0700 (PDT)
Date: Sun, 2 Jun 2024 17:00:20 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] arm/arm64: dts: arm: Use generic clock and regulator
 nodenames
Message-ID: <20240602160020.azbf7pytiu57vwo5@bogus>
References: <20240528191536.1444649-1-robh@kernel.org>
 <20240528191536.1444649-2-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528191536.1444649-2-robh@kernel.org>

On Tue, May 28, 2024 at 02:15:32PM -0500, Rob Herring (Arm) wrote:
> With the recent defining of preferred naming for fixed clock and
> regulator nodes, convert the Arm Ltd. boards to use the preferred
> names. In the cases which had a unit-address, warnings about missing
> "reg" property are fixed.
>

Thanks for the cleanup.

Do you want to take it through DT tree or prefer me to take it. I think
I have one another patch from Krzysztof for Juno DTS IIRC.

I am fine either way. In case you take it:

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep


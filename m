Return-Path: <linux-kernel+bounces-340000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E6A986D1F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 08:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0569F1C2095C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 06:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0370C18A95B;
	Thu, 26 Sep 2024 06:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LbOs5P12"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3CB13CAA5;
	Thu, 26 Sep 2024 06:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727333980; cv=none; b=QMkQKKmOfx56DWidiLXbiCU9yzX66lKlTFBwpB6XG1B/SNMgw623BGXOKnBQaj/nsB4OuqL4I8GpJ+lveB+2Z1iHuggsDuZ8dAJvf7t5x+odP5iF7nVthdYZVmoQ+6jpHmZYM6V84245kgNt/cvJn7S7baS8G+ZdyZJDvS4p6Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727333980; c=relaxed/simple;
	bh=HP+8QOe9VLGDYsUXS/y2xC5fz7bWuVs+fseDbh7f0M8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q5BKJqnh7mecgKv41l+xhhkZQxXA2zBe4OOeq778Sl6RIjiFCUeJBNS6WA2CHuYRDVe6q5448fJhJ9RXpYndCimQjYfEIxTDxUcKLdDn28kltegxyrpmOyaZ9L0lDE9hJvabukvp4I9HwCOn8YD1xyfF4okXn/WeVyLYIaymZdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LbOs5P12; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2428FC4CEC5;
	Thu, 26 Sep 2024 06:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727333979;
	bh=HP+8QOe9VLGDYsUXS/y2xC5fz7bWuVs+fseDbh7f0M8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LbOs5P129YqfPYF7VM4zaXt7TLgQXTNcAiqq5/WihGCVnBWEGI4R40oWjF0/Yb3aG
	 8HQMsQdfi5dxgGkYOcKHAEqf2nlQdZI3NMxM0HwWYv1L199T6TuWw1NmF6T5jQ4sBH
	 RCGxfOjqVTWQ2HrmlPmDH/69EcGG0b4gp/G1HvCyepM+TXnwvKP3WwERqAKC9l/19O
	 oWwNWYQYbnYl96rdq4VuYNxLDgICtOQe0BxEotirTtmK4OHHEtCPCH8yuEdndGti58
	 EEBhfp/y82nko7kEnSXfsyFPhnp0FtwEqXyK+Y7bE3AiREXlkgeO3d87tVQgvf7YVK
	 rQ14YLFUkgbvg==
Date: Thu, 26 Sep 2024 08:59:36 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Daniel Baluta <daniel.baluta@nxp.com>, Shengjiu Wang <shengjiu.wang@nxp.com>, 
	Iuliana Prodan <iuliana.prodan@nxp.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/6] dt-bindings: arm: arm,mhuv2: remove power domain
 from example client node
Message-ID: <qge5cz7w6od3jmt73hwcepoje4lv65x6dhoqdujpyaohdtopqs@yp37zt7sebge>
References: <20240925232008.205802-1-laurentiumihalcea111@gmail.com>
 <20240925232008.205802-3-laurentiumihalcea111@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240925232008.205802-3-laurentiumihalcea111@gmail.com>

On Wed, Sep 25, 2024 at 07:20:04PM -0400, Laurentiu Mihalcea wrote:
> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> 
> The number of power domains required for DT nodes using the
> 'fsl,imx8qxp-dsp' compatible is 3. Remove one power domain from
> the example client node using this compatible to align with this.
> 
> Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> ---

Your patches are not bisectable. This must be squashed.

Best regards,
Krzysztof



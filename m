Return-Path: <linux-kernel+bounces-240888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 151E7927435
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 12:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDA3F2838EC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 10:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1598E1ABC50;
	Thu,  4 Jul 2024 10:40:58 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA7D1ABC3F;
	Thu,  4 Jul 2024 10:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720089657; cv=none; b=IVEdUMuEZbZ9SPMN5sdzqEPeAyaVr3meW7hlybSZSYDh8ojtapsVXjFqEJUqiUgeQ7PBnJKbtuEYYyTA+nxGwTVqR6KzQOucZv9ogaubdmEUFmaq+PjDPDrhPaMEO6ddnJ5mbydFwvXpVB5tNQ/0RdI3gHP5CscHx230TmMXEZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720089657; c=relaxed/simple;
	bh=8aB+h6sbMTS7pnnchu/Ny/hOhV3ejsIHkFPvvrjtBH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tZQWW9M6YWB8z6A7qDryZHAYc+AJrmKmYUJ6RVks0thfOAmxMcd0C129MbDo2OOjy8S3VebV9mWijXh92LCFIFu0XqUZ0mLDFtfta9LuFI1TLKN2Eh6Q7obYHaWEUU96TQ4GRogDoh/PxbO7JqJAHQjnA8Ihv5u6XEWc4eaLSW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 70C4F367;
	Thu,  4 Jul 2024 03:41:20 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0BFC13F762;
	Thu,  4 Jul 2024 03:40:53 -0700 (PDT)
Date: Thu, 4 Jul 2024 11:40:51 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: cristian.marussi@arm.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	arm-scmi@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH RESEND] dt-bindings: firmware: arm,scmi: support system
 power protocol
Message-ID: <ZoZ8Mxjv9cIzivtk@bogus>
References: <20240628030309.1162012-1-peng.fan@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240628030309.1162012-1-peng.fan@oss.nxp.com>

On Fri, Jun 28, 2024 at 11:03:09AM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add SCMI System Power Protocol bindings, and the protocol id is 0x12.
>

I think we must have this node only if it has dedicated channel or any
other required property.

-- 
Regards,
Sudeep


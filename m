Return-Path: <linux-kernel+bounces-260480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F1BF93AA06
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 01:51:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B3F42832B0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 23:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B8EC149C6C;
	Tue, 23 Jul 2024 23:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DRflxrL8"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD991494DE;
	Tue, 23 Jul 2024 23:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721778678; cv=none; b=QFhXeP5aWBrrKmB0Qh7/AQgqnXl67MFr70egM9rA3XuDcPALEzBmNInTxM3qIk1meBjW7yHxRpNtGFOOtjBwr+hS3w/NdWzEr5nYwzcfmUJFN/KdVGvP/Vfj/dI3jLVmFSOqZ499AV/i+0MWOK39v5mcYfRBcdUgkUnwPLWk7rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721778678; c=relaxed/simple;
	bh=Wm5UoIr/OEWSQDZrBp+0/uQLHVeb0HROI6tDskMIEJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uRMZLIQ1kdqHQsw8GKvRBnGrJ+9JUsobbkDJ1+gVPCqnrlyFafxa1c3N4NMopBwrM6j9InFNYjIVhwVpSdjoQaY3s3UBGsdsdTHqqkHHlvlz8nNYvrhVgtQiAJHjUvfdBJc2Vu5QCLgdFGV+AdAZmqnvcifhtImmT/t3kWnpQEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DRflxrL8; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B1EE0E0002;
	Tue, 23 Jul 2024 23:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1721778669;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X+SKAQmjNRPaji+Q2BhvyaBaM+HsQEPmFK6Rpkla9Fg=;
	b=DRflxrL8MpVMUI+uncAzrlRx98puYtmSGXghvzQCd/+DZgH/bsKS8yRFALNOCojPtD4oDo
	5/hF9fHZOKaiiEskupQZsBbn9Y8gFeu4adMmsrCzp4rhPDQbtKOmZTMu0FzV4oevLkXX29
	/tZZ6HD3oshkLBTCq5UFv1uXLxg8veoFQ7SiAzOWssmex1/YwER/Motfc2RfRSFMqn/0/s
	SISdwrIyk2gc8rTQVRgxqTxk1yVal2EVLdrhhMx5jmKS0uHoDL6K4VR8ahQeH5apsGdpV9
	Tz0ASG0b62bTdsfSoATrToj8E3iJlI6tsuBdbaJyaH4owYgAK7gp5jq9SbboIA==
Date: Wed, 24 Jul 2024 01:51:08 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: krzk@kernel.org, Frank Li <Frank.Li@nxp.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, imx@lists.linux.dev,
	krzk+dt@kernel.org, linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org, miquel.raynal@bootlin.com,
	robh@kernel.org
Subject: Re: [PATCH v2 1/1] dt-bindings: i3c: add header for generic I3C flags
Message-ID: <172177859264.478132.7118416055894101559.b4-ty@bootlin.com>
References: <20240715225351.3237284-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240715225351.3237284-1-Frank.Li@nxp.com>
X-GND-Sasl: alexandre.belloni@bootlin.com

On Mon, 15 Jul 2024 18:53:51 -0400, Frank Li wrote:
> Add header file for generic I3C flags to avoid hard code in dts file.
> 
> 

Applied, thanks!

[1/1] dt-bindings: i3c: add header for generic I3C flags
      https://git.kernel.org/abelloni/c/3564d9eb607d

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


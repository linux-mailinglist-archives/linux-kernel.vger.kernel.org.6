Return-Path: <linux-kernel+bounces-544763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B16AEA4E503
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:08:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD27619C13C1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B7A325523C;
	Tue,  4 Mar 2025 15:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j6B9ulxg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F722298CDF;
	Tue,  4 Mar 2025 15:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741102801; cv=none; b=cPDVuS7cbV4NoaGwz9wD5Yt+Nfpmnl4Q0jieH2RS9QaflyGHNO0LVlKmgPf7h7yKHXiZfhHvnvj2Hh2RMB605UqMoRO6Cet99X3BcSW/NYkQIQgs9RHXV0OqBdRCuqrUKvmGDGAwWTWmZ6qV/WGjfeFsD9anMRRldQgnTvs9+ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741102801; c=relaxed/simple;
	bh=0nzWHKcWuWbK8/ao8glPbcdrGPVX6FDyKhLlbVZ2Pnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CtGMapIVLiUypDwdGCSG1qHoZMquIFxb6UuRj4FhPZKSBHsuzrR3gsKGZqJemtgZNRaV7mm47ilDt/4D/IQItI9O1qb7LoWMQ///dv7O+SSwWZx4+JskZ4qnuyfiqTOUtBf+dCjVWsKZDjJg1TJT9xIjM/t6IJZU/7+ydVfymjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j6B9ulxg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BD23C4CEE5;
	Tue,  4 Mar 2025 15:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741102801;
	bh=0nzWHKcWuWbK8/ao8glPbcdrGPVX6FDyKhLlbVZ2Pnk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j6B9ulxgJQWvPf7X0QEbuP+/MVSMQqLYpCaGqMSWog+pCCVVZK2liddntsw/zR5TC
	 98IkZurpy23tHavp0nT9SyAMWlzRopn5pN/ugjhD8pYRUde0Qq6Fs+ja4HR8pKsLlK
	 1cNiNn+oZM9863H5afwSC02Q+2we2bA24fcjPXoy12InyazpZnkchZDRmmAu0slp5B
	 lTQzY4h7n0vK0dLUhlqlFiUCtJZ+Vfb3hQaFeXNl7Awb/64eatix2woIrdtUoUzvNF
	 x64wKLg8lsMwmxMX7iRRXAfmm2H4nQnJprfkmr1NTJJpUBzbFpxTqwr5IAOxyC9aJ2
	 Ss9c46K9Jxl5w==
Date: Tue, 4 Mar 2025 09:39:59 -0600
From: Rob Herring <robh@kernel.org>
To: Chintan Vankar <c-vankar@ti.com>
Cc: Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Peter Rosin <peda@axentia.se>, s-vadapalli@ti.com,
	danishanwar@ti.com, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [RFC PATCH v2 1/2] devicetree: bindings: mux: reg-mux: Update
 bindings for reg-mux for new property
Message-ID: <20250304153959.GA2654372-robh@kernel.org>
References: <20250304102306.2977836-1-c-vankar@ti.com>
 <20250304102306.2977836-2-c-vankar@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304102306.2977836-2-c-vankar@ti.com>

On Tue, Mar 04, 2025 at 03:53:05PM +0530, Chintan Vankar wrote:
> DT-binding of reg-mux is defined in such a way that one need to provide
> register offset and mask in a "mux-reg-masks" property and corresponding
> register value in "idle-states" property. This constraint forces to define
> these values in such a way that "mux-reg-masks" and "idle-states" must be
> in sync with each other. This implementation would be more complex if
> specific register or set of registers need to be configured which has
> large memory space. Introduce a new property "mux-reg-masks-state" which
> allow to specify offset, mask and value as a tuple in a single property.

Maybe in hindsight that would have been better, but having 2 ways to 
specify the same thing that we have to maintain forever is not an 
improvement.

No one is making you use this binding. If you have a large number of 
muxes, then maybe you should use a specific binding.

Rob


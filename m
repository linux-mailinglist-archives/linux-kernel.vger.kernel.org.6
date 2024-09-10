Return-Path: <linux-kernel+bounces-323624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0AEB9740C0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 19:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A377228965A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 17:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD8B21A2C36;
	Tue, 10 Sep 2024 17:35:45 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CACD91A2643;
	Tue, 10 Sep 2024 17:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725989745; cv=none; b=UGppY9oxbT4StRCpNq9ABPJQDxeIgy8Lc6gf9MyGN4/Gb8v5L4cIuBl7TwEIjGv9f1cVRArur47sqlkOxTfWJOYvs8vreo8o57DlCJcY/81yYJqVcyrMAMUgjUQSolTolS4JAis/SBZ9QzOaBBJBX9UL//n4kLc3G1Pj5OIW+BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725989745; c=relaxed/simple;
	bh=v0ipeU+HY9uSgxqd58JBhZxO4jQDBIzdKMsRZxxXJ28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p4ba2lqqhhf+Ewlb5ElUFGBGcvGmr+Rz3CRH9wkTcdDpuDNEcgMfNc7RFdH4CwHdncZWUg5YZuGFWQUv2HGjftFsOWKzs7csx+FZ6lhF+JNpkLSXQTscEiZ/avu4t41j5AW0dDXcC79j9AwsTWwC4x5ZMCqCPrOolx/+cjQrSs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EA87B113E;
	Tue, 10 Sep 2024 10:36:05 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B8C263F73B;
	Tue, 10 Sep 2024 10:35:33 -0700 (PDT)
Date: Tue, 10 Sep 2024 18:35:25 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Nikunj Kela <quic_nkela@quicinc.com>
Cc: sudeep.holla@arm.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, cristian.marussi@arm.com,
	arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel@quicinc.com, quic_psodagud@quicinc.com,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v4] dt-bindings: firmware: arm,scmi: allow multiple
 instances
Message-ID: <ZuCDXQaUDfmUuh_D@pluto>
References: <20240910163456.2383372-1-quic_nkela@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240910163456.2383372-1-quic_nkela@quicinc.com>

On Tue, Sep 10, 2024 at 09:34:56AM -0700, Nikunj Kela wrote:
> This change extends scmi node name so as to allow multiple
> SCMI instances.
> 

Hi Nikunj,

LGTM.
Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>

Thanks,
Cristian



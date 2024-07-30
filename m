Return-Path: <linux-kernel+bounces-267879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8E339418A0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 18:24:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62574286A1B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 16:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9B9189916;
	Tue, 30 Jul 2024 16:23:29 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88D0F18990F;
	Tue, 30 Jul 2024 16:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722356609; cv=none; b=PeG3QFw/cQX2US0VKb9EKBdvJllNm2nORQkK3fS5KBGjMsrwPhCDVxFYK5uYEg3EctdwGKhLL7MvGyaaROQEeGTw4CuFlsHhEM+3JweJlgZk2iaa1zYOZ3jQ8uSAl02MHdobVwoO5HqSUoxz3vN9I9j880WzYHDIFEwg2mQgDNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722356609; c=relaxed/simple;
	bh=WffStKI47PzavbHJV+rtpu1pvEvWWJoVUagtZPzxrEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MchkYK0X3pH9ZbHc68vHPi0YaIzpdqaf93ZnNom1++8kaKblcGgjZmmXRsw6x7JN9rb3lI92kk1LRDCcRFpPfy4ovymOacMMzI63n4oj6GEjAk5LsAcv6WS8f48T49cVCQVhTh7Id5o0tLCkmlAF749VFXKY97zuGEAAk/DWGB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7BB601007;
	Tue, 30 Jul 2024 09:23:52 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C007D3F5A1;
	Tue, 30 Jul 2024 09:23:25 -0700 (PDT)
Date: Tue, 30 Jul 2024 17:23:22 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Luke Parkin <luke.parkin@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org, sudeep.holla@arm.com,
	cristian.marussi@arm.com
Subject: Re: [PATCH v4 4/5] firmware: arm_scmi: Create debugfs files for
 counts
Message-ID: <ZqkTeq9KRW5GPC3X@pluto>
References: <20240730093342.3558162-1-luke.parkin@arm.com>
 <20240730093342.3558162-5-luke.parkin@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730093342.3558162-5-luke.parkin@arm.com>

On Tue, Jul 30, 2024 at 10:33:41AM +0100, Luke Parkin wrote:
> Create debugfs files for the metrics in the debug_counters array
>
 
Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>

Thanks,
Cristian


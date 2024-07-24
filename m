Return-Path: <linux-kernel+bounces-261000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5280493B15D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 15:08:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3514B2359A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 13:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF534158A3C;
	Wed, 24 Jul 2024 13:07:55 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7195F15748D;
	Wed, 24 Jul 2024 13:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721826475; cv=none; b=PyPKQECAziUCIj08tTMmyohNmAPu3+GvGTB2RxtVl/MDWH/WrwP8NRfpWeWeo+fGUbgsPV4HrAaIRWZ52hH6jvpILsli9Kg0vNAmNVCaa7ffIdLpfUwZ6gJUBpSiPk8mCA72oV2N3MZu43IBZZv1VehdzsmdCH7v5yG0tlTA+AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721826475; c=relaxed/simple;
	bh=TI0EDAjBpEpNLizqpap71WadNcH57bY7rzsJTNToNEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PSDNbpsjiQ2ibQjz1CceHalO2eS25Kj/8Zt/zQMxKI3tpRr3WSg+44m7xw9LDr+PVcjKf16gw2xod/AO6CerWWbryGQE4srTn3SNENyhS2vEFEWRE3P97JLDhPEtdrDV+UhiIpvrUkcsPDnk1XLudUFrSAH734WRKo4VRM1j4h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1A79E106F;
	Wed, 24 Jul 2024 06:08:18 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 466653F766;
	Wed, 24 Jul 2024 06:07:51 -0700 (PDT)
Date: Wed, 24 Jul 2024 14:07:40 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Luke Parkin <luke.parkin@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org, sudeep.holla@arm.com,
	cristian.marussi@arm.com
Subject: Re: [PATCH v3 1/5] firmware: arm_scmi: Remove superfluous
 handle_to_scmi_info
Message-ID: <ZqD8nLvD5eIU07d0@pluto>
References: <20240715133751.2877197-1-luke.parkin@arm.com>
 <20240715133751.2877197-2-luke.parkin@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240715133751.2877197-2-luke.parkin@arm.com>

On Mon, Jul 15, 2024 at 02:37:47PM +0100, Luke Parkin wrote:
> Remove duplicate handle_to_scmi_info
> 
> Signed-off-by: Luke Parkin <luke.parkin@arm.com>
> Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>

Your Signed-off-by should always come last after any Reviewd-by, CC or
any other tag...

Thanks,
Cristian


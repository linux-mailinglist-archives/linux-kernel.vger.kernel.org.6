Return-Path: <linux-kernel+bounces-244199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A3392A0B4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 13:08:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 649CC2843BA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 11:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B1B3762D2;
	Mon,  8 Jul 2024 11:08:23 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C9DF1DA4E;
	Mon,  8 Jul 2024 11:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720436903; cv=none; b=GXukw6lEhu56s6EL0dFkJENSloNeFz1mTLdOBlvudAL198K7knpkFDlHqt0H74SrWZt7HkflgqJL3RjlltJhTfsbe5FBj1CwT6Lc1xBbMhiETmP2ZjrG+dp4nH/s+pyFci4zb58/GJsRALkQ6VC99GoaQ1olB8p7ro6pw7LLMGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720436903; c=relaxed/simple;
	bh=QZf0Mf+TWsaZ8xyWLaubxoDq5ST0ZIlFEE7fx7a4B+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cErPH/8PcIoKQJtky+zv1g9Hy6dLd8ToSZGf/bJncR2i0y5gcww5jYKemWv2GaDPt0RKM/B8hSTW/U1wNG4zPNmo+oyLXThVCZ0q3IYtqKUbwRAkZO06hVHTXxSPnFzhh8h9sWnIhSMOJaFT5rkLz4RKP+NOLJEbZ5xnQu94mxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8940D1042;
	Mon,  8 Jul 2024 04:08:44 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 89FA43F641;
	Mon,  8 Jul 2024 04:08:18 -0700 (PDT)
Date: Mon, 8 Jul 2024 12:08:16 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Luke Parkin <luke.parkin@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org, sudeep.holla@arm.com,
	cristian.marussi@arm.com
Subject: Re: [PATCH v2 1/4] firmware: arm_scmi: Remove superfluous
 handle_to_scmi_info
Message-ID: <ZovIoFfDIryOuH9Q@pluto>
References: <20240703143738.2007457-1-luke.parkin@arm.com>
 <20240703143738.2007457-2-luke.parkin@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240703143738.2007457-2-luke.parkin@arm.com>

On Wed, Jul 03, 2024 at 03:37:35PM +0100, Luke Parkin wrote:
> Remove duplicate handle_to_scmi_info

Good catch.

LGTM.
Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>

Thanks,
Cristian


Return-Path: <linux-kernel+bounces-265743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E43093F579
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 14:33:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEC68282E37
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 12:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7541148850;
	Mon, 29 Jul 2024 12:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="JC4xxslR"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C8233CC4;
	Mon, 29 Jul 2024 12:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722256383; cv=none; b=acXU7D5thwXRvU9Dcnrn7otw9JgDZTmmiU0fK+kXEwLjMfTnzXYPMu4OEsG/98p7YHx7uFn19Y8Y6/Gqz9lpKVFpMx6oAd3hHAcIamuh0rhWelg0sPJjK42AXRDlymMxWUhduI2RoKsas3bk/8g7+itxiMxXITdHsF0GQ2Z8LJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722256383; c=relaxed/simple;
	bh=486EBKZCXcRa78kDX5kskMncYP2Rrz0gd4BMaLyz2yk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xg4sMpEQG52sqOJ5WjKsJaAZGIGu89YRiFiKLw80dCCya/1gcWMFSQfQmkMs3Q7k2AuHLGaT+qg8w5OM9eGttx37ZEPtJAhh2066TZE5cxCn0aVSKFJ+kAT03bPPTmLMojpFBkD9dMMKsDYi+0CmFDmp11cZrv+7vWRkjmUdVhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=JC4xxslR; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 001C840005;
	Mon, 29 Jul 2024 12:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1722256372;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cNEaXAf9TE/pb+tSX4cZMggMhG1O+aODHSBLYm6YUnQ=;
	b=JC4xxslRNDLVUuq6ou0LJnKQnufX22/9r8b2xSMKyuvLCVC9ryVumnQb3z89D3ZEjX+f38
	RrRpaMOEm3e+ymAyornk1zrxr9XDpoyO08EGDGpT1WLL2szv4ALVDZyxtt2U8rpMb2UtgW
	IdgRRnfcQ7yYnyHvP1RSMDqoTIN4osSXl9gMjSxl4FTWKnZ2GS1BZOkEa0NuM1KAuJ9JOd
	ZDIZS8VVOW8T2HzRsArA1wAhn9dAewkRgoBkWShxARQdZVbHHwaCmbkaPWAy301Td9vwtY
	uKB08SlmtGvFDVLamr/bj3MBDYfa74Ufcy/7G/JlqlXG5bcvoDeZ5xjzGYko/Q==
Date: Mon, 29 Jul 2024 14:32:50 +0200
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, Peng Fan
 <peng.fan@nxp.com>
Subject: Re: [PATCH v2 1/2] of: property: add of_property_for_each_u64
Message-ID: <20240729143250.624060b0@booty>
In-Reply-To: <20240729-clk-u64-v2-1-ffa62ee437e6@nxp.com>
References: <20240729-clk-u64-v2-0-ffa62ee437e6@nxp.com>
	<20240729-clk-u64-v2-1-ffa62ee437e6@nxp.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: luca.ceresoli@bootlin.com

Hello Peng Fan,

On Mon, 29 Jul 2024 10:30:52 +0800
"Peng Fan (OSS)" <peng.fan@oss.nxp.com> wrote:

> From: Peng Fan <peng.fan@nxp.com>
> 
> Preparing for assigned-clock-rates-u64 support, add function
> of_property_for_each_u64 to iterate each u64 value
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


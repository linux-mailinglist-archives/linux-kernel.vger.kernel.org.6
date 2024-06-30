Return-Path: <linux-kernel+bounces-235246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C885E91D231
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 16:59:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C92C281A32
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 14:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 368F515350B;
	Sun, 30 Jun 2024 14:59:10 +0000 (UTC)
Received: from isilmar-4.linta.de (isilmar-4.linta.de [136.243.71.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015E933FE
	for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 14:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.243.71.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719759549; cv=none; b=jA9OMBMW2sVBhxypirbm5PXkv7cRkxNuNmnNu/OpSsK0UtxMRHEBqn/VNAluDQeNxQA5/2k4a2v+t3zp7Bz4JZ7Ow0Djn5eOK3+upG6q3j2tmC7lkbjDGqDY2XYP5M3LKNZgnqLEAGNxts3qBA1/bAzTETgIj5COd9+ZZWi65d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719759549; c=relaxed/simple;
	bh=2C/4g6RXcMF4HIZHAUpQHFNFVmwNgv+zhK/Ua2+qBmc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eA28GvRrkDHYhbBM5flSLVKSgQ0oqWn4GVR7u/5S4Iz942WkNjXuJHJLNevHWr706ZTneiL8gwzoUDc91I8oz+nT+XdgLmDx69Yp+6pfIOWzYJxsBqos3QGGQMcjAdw6TUvBhWwDH9q6UFUsBboJq0yuMoWlE8xUByGhuMn/RLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dominikbrodowski.net; spf=pass smtp.mailfrom=dominikbrodowski.net; arc=none smtp.client-ip=136.243.71.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dominikbrodowski.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dominikbrodowski.net
Received: from shine.dominikbrodowski.net (shine.brodo.linta [10.2.0.112])
	by isilmar-4.linta.de (Postfix) with ESMTPSA id 2F3FB200298;
	Sun, 30 Jun 2024 14:52:15 +0000 (UTC)
Received: by shine.dominikbrodowski.net (Postfix, from userid 1000)
	id CE18CA0068; Sun, 30 Jun 2024 15:34:32 +0200 (CEST)
Date: Sun, 30 Jun 2024 15:34:32 +0200
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pcmcia: bcm63xx: drop driver owner assignment
Message-ID: <ZoFe6HZhnuhfpdJg@shine.dominikbrodowski.net>
References: <20240327174647.519475-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240327174647.519475-1-krzysztof.kozlowski@linaro.org>


Am Wed, Mar 27, 2024 at 06:46:47PM +0100 schrieb Krzysztof Kozlowski:
> Core in platform_driver_register() already sets the .owner, so driver
> does not need to.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied to pcmcia-next, thanks!

Best,
	Dominik


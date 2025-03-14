Return-Path: <linux-kernel+bounces-561354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F8E0A61064
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 12:48:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF4343BD219
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 11:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1AEF1FDE1E;
	Fri, 14 Mar 2025 11:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tPnLoAjm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B20013B592;
	Fri, 14 Mar 2025 11:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741952901; cv=none; b=OGPpcoKmLI30hJNhlCPzijGWbcv7hVEjMrKbszsvdKkP0jcElJ6pLUGYAh7gbwN+bnYoegpDlW/2sa6N5ijUlOSB0uecFCBAy7oZkMPH+QUstcvPKGjkzO836MG7bcWK6hk8rHdme+0kAb2xBLVkxrVG4ZnFr5nTePqzKpTBIzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741952901; c=relaxed/simple;
	bh=TLGwM5BO2LBpAMnwwrGtTXMqE1DFWbdhaInw1tIy9Ps=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=HYAhhAvXR88gVs/oYqu1eJmqmH79fBefEMgNreNuDkB3BPUOMOLrxOXQZCl8Z0tmD3NRMe9oT4Y5P4WbddHV9Z4SK4GDAHmjndu3x9XKmFF6+bsTHLaxKmspeOJDV2zPyGe+tW9zeDy1XPLUXPC5oAKI+AUmNYvDzKaRpvW1EMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tPnLoAjm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7793AC4CEE3;
	Fri, 14 Mar 2025 11:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741952900;
	bh=TLGwM5BO2LBpAMnwwrGtTXMqE1DFWbdhaInw1tIy9Ps=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=tPnLoAjmmCeLwuUthyvyfsJyyucy8qSSp/FE3+2B0Y/DobtwsEPZ6nJwCy++PXnaH
	 4mGTAWMg7j74MgF4saZkSxWYLLpr7pFhJAwjO4vrgxsg+MHxys/Nnd0rj1CUlqEUuL
	 2Eud0Zy62s7moLJpB1uvy/Aey6ex+wP7EGSpvvwv9pKHegXaft2hf2Dq1AZqQ4WlO6
	 QpTEyzz9ceQpCeNjMhXOkrrKRwolmGpFSkW3mp/KOZsUFNFcnctJyWD5NICk7tf9cZ
	 5b+Ep88L8b+m07oUKe4XzSyOrUxtDe0jcmN+iocTDSPr40NXcnP2j892JQQeQzQXzs
	 N/7IeV/PUcpDw==
From: Lee Jones <lee@kernel.org>
To: Thomas Richard <thomas.richard@bootlin.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>
Cc: Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org, 
 kernel-janitors@vger.kernel.org
In-Reply-To: <9e812dfa-e216-4e40-bbf0-d0b63b110bb0@stanley.mountain>
References: <9e812dfa-e216-4e40-bbf0-d0b63b110bb0@stanley.mountain>
Subject: Re: (subset) [PATCH] mfd: cgbc-core: cleanup signedness in
 cgbc_session_request()
Message-Id: <174195289923.4020142.10785962895520385710.b4-ty@kernel.org>
Date: Fri, 14 Mar 2025 11:48:19 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-510f9

On Wed, 12 Mar 2025 11:34:50 +0300, Dan Carpenter wrote:
> This doesn't affect how the code works because there are some implicit
> casts, but the "ret" variable is used to hold negative error codes so
> it should be type int.
> 
> Declare it as "int" instead of "unsigned int".
> 
> 
> [...]

Applied, thanks!

[1/1] mfd: cgbc-core: cleanup signedness in cgbc_session_request()
      commit: 3ce71a089364813c5ca953d7bf527b6ba477d5da

--
Lee Jones [李琼斯]



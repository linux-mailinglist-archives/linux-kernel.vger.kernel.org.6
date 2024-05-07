Return-Path: <linux-kernel+bounces-172187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D772A8BEE97
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 23:05:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D8FE1F26102
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 21:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB3E7316E;
	Tue,  7 May 2024 21:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QcIX9YCC"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23A8187353
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 21:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715115950; cv=none; b=iGy14lgRQXWa7A+GRG0wVjgdJyYLbS9lZNxaPfBrNy8wG7VMrTzSpdOTFZdYdH4OIkT+WdcCYfYczjTHe0wZy1vbFUDcJf0dDUeCw21LFi4tLFVAzRbb3Nj4l34w1hUEIBDzMRR2rEnsRvOoWoTquFwRpCHO4ZjDWHF1wLyoomI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715115950; c=relaxed/simple;
	bh=Ub8SD0s+2tvcifJmcjiOPb2uacBifFRvgRPVoMUlAig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PH8FPb+nd8M/VeVRQ7xEPULvkk5y71Z0RXJATsaV+utn+Z4LqTLDO7aC79PMmZwsozKjH+EWghBq0hg3m+pROxIZjMftJ1Y4X8ZO8cmu5+vV5cgxUC0ZTuDJhkpNprOwBfszBkEXMLAL7omytXb2wO4CcNn/0kL0McoX3SdTsCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=QcIX9YCC; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id CADD940002;
	Tue,  7 May 2024 21:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1715115941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=frZQIdG72+aRABW5Ri2Oocaq5EiG3vpALSpmJr9JuLA=;
	b=QcIX9YCC1pc/tqho9bJXaBf3Z37vqTFgJ77Vgw9TXWAWSSa4Y+9EADooYCx2csW745N5ZB
	BxTWGjEyA0BzpTW9kFppGsBQWejTkLm1cTM4TSpquTqV2j422JDfUQpehy9GbNTVacsjjg
	zyAjxABNulzBSK6aJvB6Q+uyfimoR5zJDiCQUhXf1nWtfoB5B6t9SMuHuoYtwMK/jpa0ik
	kBnfAOEMmcJ61Ns7lSR4XFgR3c5nds52F9oBuxr82j2euUub/1nyeBnzKn5VMPRpgWgy4C
	eZHGdJ0SkkhbGGpCZZjjcPMOg5D5LlXtujZOcvWVjbrssYWv+BYqMYQ7HeUS0g==
Date: Tue, 7 May 2024 23:05:40 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
	Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
Cc: andersson@kernel.org, vkoul@kernel.org,
	manivannan.sadhasivam@linaro.org
Subject: Re: [PATCH v1] i3c: master: Enable runtime PM for master controller
Message-ID: <171511593074.988529.13434042703638402613.b4-ty@bootlin.com>
References: <20240228093407.4038399-1-quic_msavaliy@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228093407.4038399-1-quic_msavaliy@quicinc.com>
X-GND-Sasl: alexandre.belloni@bootlin.com

On Wed, 28 Feb 2024 15:04:07 +0530, Mukesh Kumar Savaliya wrote:
> Enable runtime PM for i3c master node during master registration time.
> 
> Sometimes i3c client device driver may want to control the PM of the
> parent (master) to perform the transactions and save the power in an
> efficient way by controlling the session. Hence device can call PM
> APIs by passing the parent node.
> 
> [...]

Applied, thanks!

[1/1] i3c: master: Enable runtime PM for master controller
      https://git.kernel.org/abelloni/c/fe23b69d78d7

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


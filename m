Return-Path: <linux-kernel+bounces-238049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 110B69242A4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 17:42:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B07E11F22D33
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 15:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B84471BC07B;
	Tue,  2 Jul 2024 15:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jjPJ4A44"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A781BC072
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 15:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719934962; cv=none; b=ktmLQTYZB1FH3RFKFax8UliX562/vuF9r60Y41Hrh1ZEdu5KXs4I5nfyeH1TahyaVaxghyrXfbJryNO3mTjCsFraOpCcHVrk7vkhmUtS2miDPfIEEVNAmH0l9oohPj50nxgzSwfzCdXJldsl1GFJeZPphY518sKdpwtk9rNSI34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719934962; c=relaxed/simple;
	bh=t6Yxs4HaE6O1bEqgahjGVoTgAg0PybsibHgREDvBJOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lUREEIlHElXwBic4j25DFaT2aOs+1TwxYylOf91DUz0xLH61ZnHNp2XSko8gIWHxhpTjbbvLfrE/wuvkV+1323PQMw0cqZBZa0V2nk/bHpDg626V4F+Au6BDpHvHp4VALt6Mxb8qwsw/BcuqtYteLl6ANTMdX88yCI/8g5K7tSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jjPJ4A44; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 330D360002;
	Tue,  2 Jul 2024 15:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1719934952;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kh2++094kq3DmBu80JcmSjBMq3G/fZgQjDvdh0jXcNU=;
	b=jjPJ4A443cEhcRwyZ/TohO8txRrKadPkV/4RoeAI8TrkziRq8HG2O6/tSJtdActGk/heaP
	kf/A5rZUtC+w93nvHyQkuKe9lqkJtsFrVuXJs9d3pF1vdjQf2Op2/dYLQZVoA2tD+pOZey
	3gUyzjSN1fdh1blwg7nJ1loTgBx2vSIT8iIrbZcM/NfhgZJ/vumzT5iRZKTTjQqJSm54C0
	fn6C3pYad+W4DzP42TQgVVWiLie9eG8Edn4JaZyVTEfjoeTnYOQLbPD1okWhfWXUTqHn8o
	BGTwyj4am3sRiXA6m8AuC/y4/Q1S6bMG4d8kYXgvEYvNjNpjvKnRsTYrUHviKw==
Date: Tue, 2 Jul 2024 17:42:30 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: miquel.raynal@bootlin.com, conor.culhane@silvaco.com,
	Chen Ni <nichen@iscas.ac.cn>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i3c: master: svc: Convert comma to semicolon
Message-ID: <171993493884.371587.3917562829848581690.b4-ty@bootlin.com>
References: <20240702024758.1411569-1-nichen@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240702024758.1411569-1-nichen@iscas.ac.cn>
X-GND-Sasl: alexandre.belloni@bootlin.com

On Tue, 02 Jul 2024 10:47:58 +0800, Chen Ni wrote:
> Replace a comma between expression statements by a semicolon.
> 
> 

Applied, thanks!

[1/1] i3c: master: svc: Convert comma to semicolon
      https://git.kernel.org/abelloni/c/9ea7dc97d9a1

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


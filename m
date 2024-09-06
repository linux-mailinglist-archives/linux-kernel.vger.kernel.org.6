Return-Path: <linux-kernel+bounces-319483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 987FC96FD37
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 23:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F7E62866D7
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 21:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76E71156227;
	Fri,  6 Sep 2024 21:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rNyASmjm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95C7146588
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 21:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725657592; cv=none; b=JWiLDqMzTSHXNXdIgVGlV29ciyInegdE/DzoGP/fozDxSSiQ56qt+2caj2qDHv8mYMIHwQLDYSLjVlDH0dupihe4tsh8VurrXWuhrqMJxS+CFxdWu5jclCnzLaRWy171McUD6eCAnYxz3dm5KuFLMcZwjCNU3Spp0+DKmoeD2bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725657592; c=relaxed/simple;
	bh=Lcx41B8B4l4eNdmA18BhfW14Tq62l0Q/qKMcsUVVrts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ewj4hEP6Xb4K7cEA0Iqz5ToDlvhN0E7N2LY8pNRXmtsuHDU698eP3fQ6crztkdL7ZgRbEri5Ccdua5kUh5y9jQ0/8YW6ISEPsk3wppjE09GHW7SKS+H64m7ccmVPNAbxQsgzga+k+4XYWqXxRwZZPQS+GoX38TIK2OySjyF7Or4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rNyASmjm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 037B9C4CEC4;
	Fri,  6 Sep 2024 21:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725657592;
	bh=Lcx41B8B4l4eNdmA18BhfW14Tq62l0Q/qKMcsUVVrts=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rNyASmjmzn0riERTRRQIHBnwSJNbHwmYeGT2H8qSjkrTs9DVlZ7+xxpMyHxpUTnTG
	 2RGdHyTu++MTu24b7+d5rbgCl/6/XVz8Ix2Jsn1KA/NsUh1d4ZLfBNHPX4Fvh4Bxzk
	 1QoyFaigWvbTBV4yn2QTig/MzwdTgOCNZAN4cMWNM8j0wqhXmymxaxgfP+CJ9i9v3E
	 Q34VroXXoJMlmrZ8oWR29wpADFb36wRazXWfmnW5JXCSw9T4st8+kdP4rk1YLKKFM7
	 LzMu2V2jqWUc5rZV4qMiYWrZRmwFT3K1H7nEbAisA4N5JH+dbi1jqNb59Tq1fRfzlQ
	 5dtNLJtYfpTSQ==
Date: Fri, 6 Sep 2024 15:19:50 -0600
From: Keith Busch <kbusch@kernel.org>
To: Shen Lichuan <shenlichuan@vivo.com>
Cc: axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	opensource.kernel@vivo.com
Subject: Re: [PATCH v1] nvme: Convert comma to semicolon
Message-ID: <Zttx9v6H2E1L8hBe@kbusch-mbp.mynextlight.net>
References: <20240906065815.40300-1-shenlichuan@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240906065815.40300-1-shenlichuan@vivo.com>

On Fri, Sep 06, 2024 at 02:58:15PM +0800, Shen Lichuan wrote:
> To ensure code clarity and prevent potential errors, it's advisable 
> to employ the ';' as a statement separator, except when ',' are 
> intentionally used for specific purposes.

Thanks, applied to nvme-6.12


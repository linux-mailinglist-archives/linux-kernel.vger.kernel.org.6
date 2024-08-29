Return-Path: <linux-kernel+bounces-306569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DD8C964098
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 11:53:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 082431F23359
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 09:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F74F18E02F;
	Thu, 29 Aug 2024 09:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1ap/4Jyg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F70C18E35C;
	Thu, 29 Aug 2024 09:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724925168; cv=none; b=YXwurUIzWU2hw3WYa5Px9dqFkVtOzb3CTpGrCn9dhS0dbB57RwwnrcYj1w+j3QhwMU/eTuI5vEeOdLoV4GRvAzEcAyxx+C2bXL9nbSkBj41/bCO/KCXU4NIt1WnjoqF8Xh0hDcf52L/K1a6wPqqtraxbo/uZKk2SZ2HljvlV8gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724925168; c=relaxed/simple;
	bh=ZD+PKoNjtTmRUZd3sHzBLSEyax3hi9ZSO7ExYklpmgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dr+Uv2X85cy9ZbT0UYPmY33ZLDGqGKX1EtWE9ZPZGCHofoPWUgZJvNO+pEVMAC2E3Tmg3PMuXqaB5BB+HkqYs8cuwYRDJjE+syC3kFd7l/EymTEiagCsK6+2EybdUCGaZTKvteBdwTob7pznEwZIQpGMar1rlus0ziqv7+pv56Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1ap/4Jyg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAB31C4CEC3;
	Thu, 29 Aug 2024 09:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724925168;
	bh=ZD+PKoNjtTmRUZd3sHzBLSEyax3hi9ZSO7ExYklpmgI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1ap/4JygV+NokZ1sTKXGMc2jbqGbfWl3/x/nsc89Mh0E3LXiZsvNNh787AgBA0pqw
	 WwW2dfMIlVaYVZfMDD/7vbnFURyOvJ4GfEaDhGT0g9RyYz7E+tcpORgluVZ/EpH8Gf
	 ucsQxr7GYEdJqgoab0XT/Hy8q9hblOQ+dqevKm9M=
Date: Thu, 29 Aug 2024 11:52:45 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Gabriel Tassinari <gabrieldtassinari@gmail.com>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	~lkcamp/patches@lists.sr.ht
Subject: Re: [PATCH v3] staging: rtl8192e: Fix parenthesis alignment in
 rtl_core.c:325
Message-ID: <2024082931-barrier-unknowing-e9f3@gregkh>
References: <20240826214853.21003-1-gabrieldtassinari@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826214853.21003-1-gabrieldtassinari@gmail.com>

On Mon, Aug 26, 2024 at 06:48:53PM -0300, Gabriel Tassinari wrote:
> fix parenthesis alignment in _rtl92e_qos_handle_probe_response to
> silence checkpatch warning:
> 
> CHECK: Alignment should match open parenthesis
> 
> Signed-off-by: Gabriel Tassinari <gabrieldtassinari@gmail.com>

Please do not put line numbers in the subject line.

thanks,

greg k-h


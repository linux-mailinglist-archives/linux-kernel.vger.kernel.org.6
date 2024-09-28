Return-Path: <linux-kernel+bounces-342681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D409E989199
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 23:44:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0799A1C22F8A
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 21:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F181850B6;
	Sat, 28 Sep 2024 21:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sRXuH1Op"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D81446B4;
	Sat, 28 Sep 2024 21:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727559891; cv=none; b=i4DanZ9ffOqAadHBhc5nBCm4qjLlKKw6W+NLW5Z//2DRlkpOz+OaZdOlmCh57zXhz6WJh+vt8qwa4/nZMig2MkkyTfz8W5477wuFQxc3hIXptexwD+Dn46Ozmfb0v3HyN+FW35CMev+x8+J9rPsANOTP+qOdloE9BzHy011j6nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727559891; c=relaxed/simple;
	bh=qQ5l8+kOSeo0inL9tnQ9NUsv8sYBzhL7D9r7Se+a3gc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oU1cy0GeVx4cuYeZ0hZQUQHexoz6vvYdmAOcUm1CvBSsAkrRGflJ3tI9ZFek+B5CB7o2ZYYDlpuRigf7wdT06WH7DDsa5z57SHRfXDPGI4q5qwBTsdXTBsmKrP3mnL29tHxLOQWFDXCFc2reM2uNwctFbJUVAfbKYeWK37tbA+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sRXuH1Op; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E06CC4CEC3;
	Sat, 28 Sep 2024 21:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727559890;
	bh=qQ5l8+kOSeo0inL9tnQ9NUsv8sYBzhL7D9r7Se+a3gc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sRXuH1OpnHGGSUjBxJWfUiXBrHOOxygk5OSUy7eXOIBA+l+H4nCVIqGIggEaa7bzj
	 pa8nrYujFcBlqT3XgYa74uofFuiJXg9QQ5dJQTNYJAwy88vCmvqNTtsBubPzdqKrQT
	 qk4QWBernhH0Y6C5Y7rBSLVA//0EZ1TJ3Q3faMYLHaRQbwuSLhQhl7yRJwKhKAZQEu
	 drXjFiqZ2OOH174MOcs6b7IrNjrs2RsE2bMctxax3zGlTi59EvZM8X9l896PCePPNQ
	 lcymYDHrMibMv3gJzMJ3AoyswCLrEs4rlcvXt0z4C82a9K8RKHIvG/MUUkSOgt2Y2S
	 YYSvk/NA6KHuQ==
Date: Sat, 28 Sep 2024 14:44:49 -0700
From: Kees Cook <kees@kernel.org>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>, tech-board-discuss@lists.linux.dev,
	linux-kernel@vger.kernel.org, ksummit@lists.linux.dev,
	tab-elections@lists.linux.dev,
	Dan Williams <dan.j.williams@intel.com>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Dave Hansen <dave.hansen@intel.com>, Shuah Khan <shuah@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Jiri Kosina <jikos@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Lorenzo Pieralisi <lorenzo.pieralisi@gmail.com>,
	Amit Shah <amit@kernel.org>,
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Subject: Re: Results of the 2024 TAB election
Message-ID: <202409281424.869DD58F4@keescook>
References: <87y13bc05z.fsf@trenco.lwn.net>
 <a38ef481-b66e-49d8-bc74-56c1943c2527@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a38ef481-b66e-49d8-bc74-56c1943c2527@linuxfoundation.org>

On Sat, Sep 28, 2024 at 12:15:42PM -0600, Shuah Khan wrote:
> On 9/28/24 08:39, Jonathan Corbet wrote:
> > There were 934 eligible voters in this year's TAB election; 229 of them
> > cast ballots.  The results were (with the top five winning seats):
> 
> That is about < 25% turnout even after keeping the polls open for more
> than week.

This is normal; we're up from last year. I've been tracking these stats
since we converted from in-person to online voting since our major concern
was making sure we didn't disenfranchise anyone while increasing the
number of eligible (and active) participants. It fluctuates a bit over
the years:

2024: 229/934:	24.5%
2023: 203/992:	20.5%
2022: 267/960:	27.8%
2021: 237/1012:	23.4%
2020: 235/955:	24.6%
2019: 174/?*		(first online)
2018: 95/95      	(last in person)

-Kees

*I can't find this year's data right now -- my brain is still half
working after fighting covid this past week

-- 
Kees Cook


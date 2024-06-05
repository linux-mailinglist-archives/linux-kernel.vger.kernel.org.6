Return-Path: <linux-kernel+bounces-201702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A81EF8FC1F3
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 04:43:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58E7E1F232C9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 02:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D9C61FF2;
	Wed,  5 Jun 2024 02:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ifI7cUBW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0E4184E;
	Wed,  5 Jun 2024 02:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717555421; cv=none; b=hbyAz3mdqJ4unVygAb2fvddKLx77phHOT+CV+6tzO7JCFGcXFLmJIis9J7ImxGJezzG92QY/EpZ1FXUzrS2iWYc5rLhS8AHNx2VJuGBPzViYM5LziEopUJ+CMhS67ZzCI+0b1dRXW/k1XvChdgrDQkZ67E8Fn7QNN3DmF9FXA54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717555421; c=relaxed/simple;
	bh=s1xG9VyBsAWZB8EftOt/RZNgSlV2dMJAzrcx2jd1Mu4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CyZkBkaKs0VPeyhipdruC2yombJlI5BKy0vchcivCHB4ijmVhLORaQkUB1eD0JHOHX+fvBtwruNK5vyrkD7WKjZjcf/GH91i4wGaYjVGvTzJl1XQPCTkinHrv8QzCuR7N5vUPhu8OC+rWdB/uYoxcy5rl47SyFgK7fo6rcpGEYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ifI7cUBW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCF4FC2BBFC;
	Wed,  5 Jun 2024 02:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717555420;
	bh=s1xG9VyBsAWZB8EftOt/RZNgSlV2dMJAzrcx2jd1Mu4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ifI7cUBWyIMdju/27Qxq3NuXNYMOS/6Mvw9RGFG4lQgBSPt4xExt6FSY2e0kbQc4e
	 r1cqDBp7MGvKXh+oXKB0T61nf6GB0YED5a95096XRNa0SoklD6vtYimrtxHE0GAv7m
	 MWYodJLVG1wDLvnLGP88qrV9ekYk5p+x+xNddex81ghI7pmkPer17ohD2HmziEH/jB
	 emypOBEEuSTYlERFyapvqpX9+4AEUi3hPBPC5MThkCXZwFm+I+C7wRczHcTSajUWJo
	 UOpHX32sJlrtqef95fd2iQWhZCX3AGfsfUozVYdGdl3V05Lh4ZWCC3n9fKDan/Y81e
	 N8Vjp0OiW1Mew==
Date: Wed, 5 Jun 2024 02:43:36 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Daisuke Nojiri <dnojiri@chromium.org>
Cc: Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Reka Norman <rekanorman@chromium.org>,
	Tzung-Bi Shih <tzungbi@chromium.org>,
	Abhishek Pandit-Subedi <abhishekpandit@google.com>,
	Gwendal Grignou <gwendal@chromium.org>,
	Pavan Holla <pholla@chromium.org>,
	Ching-Kang Yen <chingkang@chromium.org>,
	Lukasz Majczak <lma@chromium.org>, chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] platform/chrome: Add struct
 ec_response_get_next_event_v3
Message-ID: <Zl_Q2OrzKlN2mI80@google.com>
References: <20240604005354.2294468-1-dnojiri@chromium.org>
 <20240604170552.2517189-1-dnojiri@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604170552.2517189-1-dnojiri@chromium.org>

On Tue, Jun 04, 2024 at 10:01:48AM -0700, Daisuke Nojiri wrote:
> Add struct ec_response_get_next_event_v3 to upgrade
> EC_CMD_GET_NEXT_EVENT to version 3.

Something wrong: it should provide a cover letter for the series and also it
should be v2...

Anyway, the patches are clear to me.  Applied.


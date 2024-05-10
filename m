Return-Path: <linux-kernel+bounces-176148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF388C2AC4
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 21:44:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BEBF9B22980
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 19:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A70D4AEF0;
	Fri, 10 May 2024 19:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OsjhDhV0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77D9487B3
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 19:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715370271; cv=none; b=q/S2zCfRx8Dl19M0G1wrAv501nohQw+daccOAKrTHsaTXcYkHT3Y0ja5RxE3jAb1eZwJNVfnryy6Xee8SaBKgv7yX64jICKlu+MuTTAaRSdK17Vh9jp4JTgUeCOuH2Tyzs2xU4QErWzJVhlvX0Qs1oBnonGnXgOKJ4n/wkhnves=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715370271; c=relaxed/simple;
	bh=6WHrokffdc3D0GgwI0G8WA2ErBij2v/GI68Mp2FxCxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=twR13+rgRMuvz1zh6RdrF+pb3SD8Bhy4j22U4QQQB9MXEKfh9dxFf5rOpAkq3yZ+VINT3x7yQysugJZQW+SgNK6QV3sKg1YV+WnFgONTmFBqvXBMPulrPJs83mvjjuuVPQrPv47oFsU27+QlLPPB13lYz4imWRl57BFjaczjbCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OsjhDhV0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 502D2C113CC;
	Fri, 10 May 2024 19:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715370270;
	bh=6WHrokffdc3D0GgwI0G8WA2ErBij2v/GI68Mp2FxCxw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OsjhDhV0dNIT2ABSq+W/F1jbrOvxnU0qoK22O3ENFpZh6YvRLbKp4scauR8UznA2N
	 E4yRr1wuxANzLSgPNrsJ3osgCA/QKCzUfo0Ay95iNse1sO9zMWLA4fp5YE4TczvNhz
	 dtV+MdEjWeT66HZO6NQkcrLJbhqg1GTUiyp/JdjfC+B9kHOanmYZepFsEQpvznZiOY
	 soKJkQ0A3JOAoMm2rF5AyqejZAnsC4vyET2h6kSjiRr/oWt6UNIa/1NIsEFs/YT69+
	 tSToxXlmrPieqNj33dyIdDwmUI8dluB/j0aGk0vQubDwHL3+1wBVMcRWJ4MhPSIsV8
	 4H6srFwajTPAQ==
Date: Fri, 10 May 2024 12:44:28 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Siddh Raman Pant <siddh.raman.pant@oracle.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] objtool: builtin-check: Use "action" in opts_valid error
 message to be consistent with help
Message-ID: <20240510194428.mzt6vxvlkftyijau@treble>
References: <20240510093257.82634-1-siddh.raman.pant@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240510093257.82634-1-siddh.raman.pant@oracle.com>

On Fri, May 10, 2024 at 03:02:57PM +0530, Siddh Raman Pant wrote:
> The help message mentions the main options as "actions", which is
> different from the optional "options". But the check error messages
> outputs "option" or "command" for referring to actions.
> 
> Hence, make the error messages consistent with help.
> 
> Signed-off-by: Siddh Raman Pant <siddh.raman.pant@oracle.com>

Queued, thanks!

-- 
Josh


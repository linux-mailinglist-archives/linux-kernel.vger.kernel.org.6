Return-Path: <linux-kernel+bounces-259034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 045FF93903D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 15:58:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07A621C21605
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 13:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEBEB16D9CC;
	Mon, 22 Jul 2024 13:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NaQ+0gHk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C362216CD33
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 13:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721656699; cv=none; b=bTfdT0T5ZugATqVIPT+nGIPhTPTuIJBUitWN/RFpB1k8GNX4q9sKs1sx4AtCst72LVYRkUstxhftGyCQ0lpdZQTa+TtSZEA+McQA2FXajazRBX9HOzfSb0hIuVwMTNMGkz7TbspfpAl6A29G6tR7UfFHAmJ4eU/99gcX84T9pk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721656699; c=relaxed/simple;
	bh=i59ZIV8Js9XjLGiNa63j4z2h5CGqc0V9pfAD5DVM/Yw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fmI6N0CxLHI9PNohSbx4uXbTJxisJSUrqEd39rlOWN+hVPa/JybLIAKJZ9m4JIQr0L18CU8MMVM8w4JEjBMJiKwM+pFot+HbIqq1LasggjQX25xDhksJejxY+UsSIoK/pOQ0ASw6gdKHmpXg2rvgwbcOHsVAp4ogyaaUi2qTR+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NaQ+0gHk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50D92C116B1;
	Mon, 22 Jul 2024 13:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721656699;
	bh=i59ZIV8Js9XjLGiNa63j4z2h5CGqc0V9pfAD5DVM/Yw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NaQ+0gHk0n+YSM9Z/voXr5z6gdhO5X5Aif4hRVaS/h7ywqlQSz5DizxAPa8agZpqq
	 qu0UBRVJ5AJr5fgsOqx+tvDak0XLKNTMJaQVsO/fwZ5XIqthzuYvXEnqDXMYhLCbgS
	 89YKvDtORS14owUN/zKApTiL+DpqdBODiNKBtIIQ=
Date: Mon, 22 Jul 2024 09:58:18 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Benjamin Tissoires <bentiss@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Jiri Kosina <jikos@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] HID for 6.11
Message-ID: <20240722-marvellous-talented-magpie-ef4ca9@lemur>
References: <uirri5bsktq5pk2tu4gs2u22qimjcn7hi66ek6gbj65qyczfex@yjy4brkoixfv>
 <c52b7bf6-734b-49fd-96e3-e4cde406f4e0@linaro.org>
 <3610ec4c-524a-4cd7-93a9-16023618a49d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3610ec4c-524a-4cd7-93a9-16023618a49d@kernel.org>

On Mon, Jul 22, 2024 at 03:32:48PM GMT, Krzysztof Kozlowski wrote:
> > this commit broke b4 for everyone starting next-20240719, as it's
> > an empty cover letter with b4 tracking information
> 
> Konrad gave me idea which could at least protect final tree from such
> mistakes - commit hook for merges, something like:
> 
> https://github.com/krzk/tools/blob/master/linux/verify_b4.sh
> https://github.com/krzk/tools/blob/master/linux/git-hooks-post-merge

I'll include something like this into the contrib section.

Unfortunately, I'm not sure we can ever completely avoid this, but perhaps
linux-next can add a check to see if any of the commits in a merge contain
"--b4-submit-tracking--" and then refuse to consider it?

-K


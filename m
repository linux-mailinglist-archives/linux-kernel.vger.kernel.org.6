Return-Path: <linux-kernel+bounces-259285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BA00939388
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 20:17:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C4E11C215B0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 18:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9423816F8E9;
	Mon, 22 Jul 2024 18:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Wr8PTJXL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B201B16E88D
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 18:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721672254; cv=none; b=AkfHkFTWEsLDOEpr1M2K9xh6ThahnLYYWZH63wuIcmPJYj2tl5410nFzVppa1U4wcqQf4IiQO08j6Pdy7gO4UKuvH4UQEIY1jIfqGJqqG26rxQ9x08szyCrVLIvyVNut7s6qE+pvcDpqYg1/rU/+wM85c7gD81Z/3+LF9G7qE1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721672254; c=relaxed/simple;
	bh=O2JcFeqD1n6NrBQf+JZXUJJ7YFCKoFWwOmkMc+ON6V4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UBKO21wAGuOqVJeDi5lwt1f+0GLfCjkOayiPhoQ9n9ukKBK9JlpqiUu2RvQV+m5JgQWFpQRVITkfBD/Qw19Q+fW/GtBpRoiaQ0YEzGAMOcNHpW+0Laec8oH7djebHe32fs3nFbpd7ROoz7SLeU1nbWGLwx3RoA18e6qxQefbg6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Wr8PTJXL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19505C116B1;
	Mon, 22 Jul 2024 18:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721672254;
	bh=O2JcFeqD1n6NrBQf+JZXUJJ7YFCKoFWwOmkMc+ON6V4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Wr8PTJXLtWv2zwWjkwQOHCUKXy2dxnmPoVqhvcVX4bkf4eTisbOQaUw0dex8ik17M
	 SkGJ4wHp1bJFx329Vn0ebY551b82rmzR29/y7W8O0aJ3JWrBsI7U6ar1WIXTvP/7hr
	 TuVpX+ZYZxyhLdZuvr000cF3f4SAlL/jDWuwMcWk=
Date: Mon, 22 Jul 2024 14:17:33 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Benjamin Tissoires <bentiss@kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Jiri Kosina <jikos@kernel.org>, linux-kernel@vger.kernel.org, 
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [GIT PULL] HID for 6.11
Message-ID: <20240722-accomplished-delectable-kingfisher-cc89b9@lemur>
References: <uirri5bsktq5pk2tu4gs2u22qimjcn7hi66ek6gbj65qyczfex@yjy4brkoixfv>
 <c52b7bf6-734b-49fd-96e3-e4cde406f4e0@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c52b7bf6-734b-49fd-96e3-e4cde406f4e0@linaro.org>

On Mon, Jul 22, 2024 at 02:46:39PM GMT, Konrad Dybcio wrote:
> this commit broke b4 for everyone starting next-20240719, as it's
> an empty cover letter with b4 tracking information

I just committed a change that ignores any cover letters not made by the user
themselves. This is not a perfect fix, but I believe it should help in such
situations.

-K


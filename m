Return-Path: <linux-kernel+bounces-333185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B83497C50B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 09:45:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1727A1F22606
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 07:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04F21194C6E;
	Thu, 19 Sep 2024 07:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NNAevjV8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60EAC22098;
	Thu, 19 Sep 2024 07:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726731896; cv=none; b=rQ9QESsb3CJjMm5uxjt6eUbHg4azN6pA0vDiUNJoEWvSmiW1+Kvm8vTDZhtlegHItyzytbQInZwXp/VYHMnnpKYIr83eMvPDtlrGjbCnPpqbj9ALfQ2q8QFdplUruCEjZsk02WA2iSn0msP8F6vr8TADBSao9sK2nQ6z0OhdLVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726731896; c=relaxed/simple;
	bh=N/tB5kurtPU5UipR1x6mXZYuDqe3q1sB0b5AxUJp0TM=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=aPwOdK0Kr/TRK1B0JLqO5JKrDDGjhY0hrJUVNXNHVBBGc63zyNf8xx1/rbCYYcqm9/br3Z8GL3gGA/p0+3p96FqiSjGx8lB9QtmwVS2ynis3uZIPoD8pJXqRl6B3X9aR1nLgnHOAn+o3BS0UseXABVRNz8Ec19xyTwnyqOSQ4J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NNAevjV8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A000CC4CEC4;
	Thu, 19 Sep 2024 07:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726731896;
	bh=N/tB5kurtPU5UipR1x6mXZYuDqe3q1sB0b5AxUJp0TM=;
	h=From:To:List-Id:Cc:Subject:References:Date:In-Reply-To:From;
	b=NNAevjV8ih7g1atCXk0IekM/cPzw6JUwk7EGJ23E0CXyCm82bA+qWIznwSdEhor2O
	 WxGPEvKRmM7EZT1ytV+iV3UDms1c8Jvy9EY3UOrsgi+rlzVMdqLZZTFbNxbOCqGa6E
	 QgruianCkw3Oy1tWDXtcYBdaF5njvo2oy84jr9v+oq3Wli+Y5EdIXFmgB0ZLsyNeG4
	 wPbGjLZoHwDOXhVHO57BAbwBfJODF+36YNa05/ZEdl7Qd1K5T5T5yiOTBW5X9muGue
	 sb2KR0ECPDI0+V76X3BA377MaRU9NAxntyjhLhuPTPMCKtp3HnA5HRz9rhCQkXQUD/
	 tK5YbUp4J3T9Q==
From: Kalle Valo <kvalo@kernel.org>
To: "Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info>
Cc: Christian Heusel <christian@heusel.eu>,  linux-firmware@kernel.org,
  Linux regressions mailing list <regressions@lists.linux.dev>,
  linux-kernel@vger.kernel.org,
    ath12k@lists.infradead.org
Subject: Re: [REGRESSION] Update of linux-firmware breaks wifi on Thinkpad T14
References: <44ae68d2-24b6-49d2-a4f9-ae9cbf6f9950@heusel.eu>
	<a6ea491c-f238-4c84-a51a-3304f6781468@leemhuis.info>
Date: Thu, 19 Sep 2024 10:44:52 +0300
In-Reply-To: <a6ea491c-f238-4c84-a51a-3304f6781468@leemhuis.info> (Linux
	regression tracking's message of "Mon, 16 Sep 2024 14:53:06 +0200")
Message-ID: <87r09g9jez.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Linux regression tracking (Thorsten Leemhuis)"
<regressions@leemhuis.info> writes:

> On 16.09.24 12:49, Christian Heusel wrote:
>> 
>> the commit 82318c96 ("ath12k: WCN7850 hw2.0: update board-2.bin") in the
>> linux firmware repository apparently breaks card recognition in Thinkpad
>> T14 laptops with the following journal entries:
>
> TWIMC, another report (that is 5 minutes older :-D ) about this can be
> found here: https://lore.kernel.org/all/87bk0nc1yb.wl-tiwai%40suse.de

And this is now tracked in bugzilla:

https://bugzilla.kernel.org/show_bug.cgi?id=219282

Please cc the ath12k list for all ath12k related issues, adding it now.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


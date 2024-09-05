Return-Path: <linux-kernel+bounces-316948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D3896D76D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 13:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25E481C233E0
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 11:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9FAF199E9F;
	Thu,  5 Sep 2024 11:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="QPQLjAG3"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA41A1922F9;
	Thu,  5 Sep 2024 11:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725536615; cv=none; b=DLbg4CCG3ftS/vN/yC/rq1CPL4b4e5ldp6TOylbqBXvwGiZPcRTWMnjk7KsvP5WNjQ26UKWKq40qWYUc28DcKGkCZ5BC+BUsJo2JbKEcq9YykoVAESBLixEJjzZ8k38nTjZasFBXgb2enws+sOEvnzsYHOvvgqRqzPAD8mo4Yao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725536615; c=relaxed/simple;
	bh=35/ZddT9DwSfIBCt1+negDNWmVYYzBZtFuHckYVDwHQ=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=GxLfSQGwmmmsoW5u22ndO1NaJv6PeAteR13iBvUTUY8xbSC1w0y2pLsAATLipIoh5+B9csOv3nUYTdJaPVxrfXUBjBrOfdKaDliv88kCj2ypgMx1fYHSmryobdJphdbAxFZ2gtjaq7moEobE6WRkwVZ8QHvxGkah+K4sL4ZTI1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=QPQLjAG3; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1725536609;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P0Ur2BPImMA0ASLf+1LG8Tkzaux8tXdSw6YWPA1hiac=;
	b=QPQLjAG3dBUqXqxYSNytajB1xh++6w2NDLVV+q196vOaXJSQRcdm6/3JSRJXxocJI7UKl4
	tBfT05ynWkc0jLqQ77bxv6U1+Di5InRimdFVfT7YsPCR/+eULog3x5BmXmsBpZ6adJQlNL
	57qCDyDyfY+qFrBGI1PSri1LqIISlpkvGTJ4zaiuxpGdRaRy+wr+kgb/NhIj2eMboFSDIE
	87L1vSXQ5KxNZnxz07LOkUneWbs6/BDgQ/VvcugCHrYBr2PFCa7AOOLaho7ANYQR/DqTmj
	2Ml3kTWB7jBe66qhe7O8BFtv+wEq0XqOG3nN5tUb9vYcWn5ggT8rusmV4vwljA==
Date: Thu, 05 Sep 2024 13:43:29 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-rockchip@lists.infradead.org, heiko@sntech.de,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 linux-kernel@vger.kernel.org, Diederik de Haas <didi.debian@cknow.org>
Subject: Re: [PATCH] arm64: dts: rockchip: Add a few aliases to the PineTab2
 dtsi
In-Reply-To: <c820085c-a4f4-4d03-9df8-733a79e911c0@kernel.org>
References: <987e68d1c5e9a0cc56d730aec87246aa5ab8ea14.1725535770.git.dsimic@manjaro.org>
 <c820085c-a4f4-4d03-9df8-733a79e911c0@kernel.org>
Message-ID: <946b8248f5b282a8532c8532a3eda98e@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Krzysztof,

On 2024-09-05 13:39, Krzysztof Kozlowski wrote:
> On 05/09/2024 13:32, Dragan Simic wrote:
>> Sprinkle a few commonly used aliases onto the PineTab2 dtsi file, to 
>> improve
>> its readability a bit, to make it easier to refer to the actual nodes 
>> later,
>> if needed, and to add a bit more detail to some of the labels.
>> 
>> No functional changes are introduced, which was validated by 
>> decompiling and
>> comparing all affected board dtb files before and after these changes. 
>>  When
>> compared with the decompiled original dtb files, some of the phandles 
>> in the
>> updated dtb files have different values, and the updated dtb files 
>> contain
>> some additional phandles and additional symbols that come from the 
>> introduced
>> aliases, but they still effectively remain the same as the originals.
>> 
>> Suggested-by: Diederik de Haas <didi.debian@cknow.org>
>> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
>> ---
> 
> Unused aliases do not improve readability, so for me this change is
> making code worse without valid reason.

Then why do we already have, for example, unused "rk817_charger: 
charger"
aliases in quite a few board dts(i) files?  If those are actually seen 
as
redundant, we should remove all of them.


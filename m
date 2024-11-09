Return-Path: <linux-kernel+bounces-402769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 890459C2BED
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 11:37:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0543CB223C6
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 10:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3757C15098A;
	Sat,  9 Nov 2024 10:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kESBCsyG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A064EB38;
	Sat,  9 Nov 2024 10:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731148635; cv=none; b=FwH0burDrwokLextxTasOaytXGzSq5KlYWjdSbHIlw1/26NpF43EWPahVOxyvk88RYZCGchV0j+uQFKKfhowu6Z2KsQvHU0fBt0B+FOM92JLDWDgRQX4gRJ+/Z8xmXkPHZtVVFQ6jFhg5Sv+0f4lEaFl73qvmHju8sXQEEs95cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731148635; c=relaxed/simple;
	bh=gMPixpittUSQtC4V67E3ap7qOeN09OgTLEP0ENrCqYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ym2X74Xwy82zRTO+WV4jAozh54ZUhH5EiZH6l4JHGOYIoOcnT0YsBEhNM4XmK0WGy9HqoKNrOBIK7u9GDK/+DlMd1weH7jKjiQcgiz3O6nngSNF0W2SADm9x1UlXLcEvuRKLlHFWKHaCGzeu3G4BgcQnwPJj/Clx+Ukoco8gNEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kESBCsyG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4071FC4CECE;
	Sat,  9 Nov 2024 10:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731148635;
	bh=gMPixpittUSQtC4V67E3ap7qOeN09OgTLEP0ENrCqYw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kESBCsyGNRpT3fI0KfDVcXlzHelqP7VRXcH3vjamK0D32rsCSDYoxoB8A5rwYceLH
	 2yXUkp2hdtt66mW/etQmL9ER3njIORk7qwgYjqh0Fteq3fvrLZ6HP4hh290+ZpZ+ht
	 SLH/NWpArifonohcEnbtIWAwpWWbgWVgikm0XcvQvMDN90LFhDzmjkjqNoZR7ZJBa/
	 fZAvS/HZNQNN8vhzLNNOYyD119G+Qm2b41XThr8eVQk9TRxThsEKNBzO9ezidFeSaK
	 0v5YKwizxx4u4BrLZsASHF8c1jLiiMvI4UrjCHRT+KoNF3QsbuY1oU4SYgSWk5aWsh
	 xp8501EnZEDGw==
Date: Sat, 9 Nov 2024 11:37:11 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org, 
	ssantosh@kernel.org, nm@ti.com, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, s-anna@ti.com, kristo@kernel.org, 
	vigneshr@ti.com, srk@ti.com, Roger Quadros <rogerq@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: soc: ti: pruss: Add clocks for ICSSG
Message-ID: <ri4oyjhoasvzcwpmsmbrbnydyc6eo2a5vybmgx3mw4k2j5hdtq@iz6oewkuf77r>
References: <20241108142946.2286098-1-danishanwar@ti.com>
 <20241108142946.2286098-2-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241108142946.2286098-2-danishanwar@ti.com>

On Fri, Nov 08, 2024 at 07:59:45PM +0530, MD Danish Anwar wrote:
> Add clocks, assigned-clocks and assigned-clock-parents for ICSSG

Nothing improved. Actually got worse - not even accurate anymore.

Read carefully my last comment: I asked why. Where is the answer?

Please keep above guidance for all your commits. All of them must answer
why.

Best regards,
Krzysztof



Return-Path: <linux-kernel+bounces-325434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04DA39759A0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 19:40:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFC1C285A02
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 17:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F741B78F3;
	Wed, 11 Sep 2024 17:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eg0KEVR5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8490D1B653E;
	Wed, 11 Sep 2024 17:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726076358; cv=none; b=NGtyxv7vz6cWZEWDr/tP5e7iBGf68Nma0ofiXEMYGWfFFiP3DkMEAl8uqX7JiwjAb5zd06Kv8K6hUtSekClJEXMsXEtpBY0nVKlDzPMX9ZRssO71JhikswfA6EaFpTHqurz2vJ6wiyiLdWzdy2Cjfafg6t3xUdTx7so/1mjHG3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726076358; c=relaxed/simple;
	bh=uMeFWF2Z/vDZxatV5dQcimGupJ2BdpKuDkaxpFHfsEA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q4tMJQr88L58yrGvH9kL2Mh1PLI/7plUMU0CV+w6aTktPP6q9gHwXyrUxai5ddkP+8sxnAVmxC3BLP8rx/5qzKuHRcsw61YUApEqlIuCY72VdnDi3FHW4/69X/Bb/WQTWX2vBHNz+l1p5wCgql+3uy5QFlhCpcQjYtKdUymHqV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eg0KEVR5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45CAEC4CEC0;
	Wed, 11 Sep 2024 17:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726076358;
	bh=uMeFWF2Z/vDZxatV5dQcimGupJ2BdpKuDkaxpFHfsEA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Eg0KEVR52tTVl61zrQ1zLJ2/VflbdpPvJ+6SjWbMHn62vYHPsvt+AMYVYZGJRMlh9
	 P6vm2AVxIG2GrvzYxRH2+rfvB7qc1Sy5K7mh/RtyNtVyvGMzFrPtjmzFa0sLeA/fmS
	 yfazM/74P6ks5eSh7qVuzaUOPS+0uGlNgThj9naC8OSqB9ekD3RFMfpq+v0Wvd9q77
	 XBKDUh/3XQFyPa6nAeEeIazgzonVJZ/AtgoWSr2Is/BBVGEBp5kwSq3OnmaqgsT8K1
	 iq43ydfsEug7gDu1si1R5jJII9RW/tpOD6YsNFEkuTcPY6+dFpf+/5fVv+7z+8ZWL8
	 fNbEtH99kfnOQ==
Message-ID: <16d70285-cbec-4378-98eb-b522a0efbbe6@kernel.org>
Date: Wed, 11 Sep 2024 19:39:07 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] rust: kernel: Add Platform device and driver
 abstractions
To: Ayush Singh <ayushdevel1325@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Ayush Singh <ayush@beagleboard.org>, fabien.parent@linaro.org,
 d-gole@ti.com, lorforlinux@beagleboard.org, jkridner@beagleboard.org,
 robertcnelson@beagleboard.org, Andrew Davis <afd@ti.com>,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Derek Kiernan <derek.kiernan@amd.com>,
 Dragan Cvetic <dragan.cvetic@amd.com>, Arnd Bergmann <arnd@arndb.de>,
 Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Tero Kristo <kristo@kernel.org>, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20240911-mikrobus-dt-v1-0-3ded4dc879e7@beagleboard.org>
 <20240911-mikrobus-dt-v1-1-3ded4dc879e7@beagleboard.org>
 <2024091106-scouring-smitten-e740@gregkh>
 <bd542178-af1c-439d-bde4-9865cf6c853c@gmail.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <bd542178-af1c-439d-bde4-9865cf6c853c@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/11/24 5:52 PM, Ayush Singh wrote:
> Sure, can you provide me a link to patches or maybe the branch containing that 
> work? I also think it would be good to have the link in Zulip discussion for 
> Platform Device and Driver.

Sure, please see [1]. But please be aware that I plan to rework some parts
before sending out the next version.

[1] https://github.com/Rust-for-Linux/linux/tree/staging/rust-device


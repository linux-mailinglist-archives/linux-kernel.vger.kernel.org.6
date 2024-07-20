Return-Path: <linux-kernel+bounces-257916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE3B39380D2
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 12:49:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0E4E1F215F9
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 10:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8034884D2C;
	Sat, 20 Jul 2024 10:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uqkPnC9Q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D0B2030B;
	Sat, 20 Jul 2024 10:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721472533; cv=none; b=kjISt4+NuUnF9yMTBu2i8rXxQ4lcRiBOxj7qciRtCNQXpKdiCyvR+o2Q0GnznKtSCcrpr7bAlxMMsfIL+vfS94bqxDwvK6KsDsnPl0YefVIfsLEsCnm2xJyD8ndC31WFVRxq8trLuV1NWxAfTudi+3Fuq/gEbbp7pCNcgaQ4mas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721472533; c=relaxed/simple;
	bh=bjmi12JuBLUr7ya8bJerP687b1Viefc3MkWkxxykLc4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OiOtzVL0wjvBMJoN9tNKNFvSBTvs1AUZ7c5+o8G5wbYJQ6qudjeEf51JoWDJM1CBmNU3/N6/CVYhGy+BWbz0ccB1Wav6d8WWxIMgTYhcyjCJBk2QL8VZY2FULG8blmD7+n2Bw6zziBl5QJv7r0d+V9Vo8e7H0zppFCvkXMMu7Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uqkPnC9Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 634E7C2BD10;
	Sat, 20 Jul 2024 10:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721472533;
	bh=bjmi12JuBLUr7ya8bJerP687b1Viefc3MkWkxxykLc4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uqkPnC9Q1tXkQ8SRq3y0i7DLLlbH6TeMYA/VI2dasaN94OprbxW42GED7vIkWKsx6
	 AB5+y6v6TIJmuUQ49FIzogDj4rUQlPAYxmvLT3pQPSINww5ZdFqhqcrEhOidzWcGtq
	 sb4XPccBzGZFib9auugsbx0D7BDm/ogEckM/pWQCbl56qppo9FHK0j7/XXHkuiNeaU
	 KL4FRsZwKMzvOf+Jr8sjfcO6bFZOa03kI07bhEzp/ecK/Yip31VmlBY4uPUhawBKjS
	 5PeUIlAw0sNjXMEO6fEKaVf9EQiElMrhXwf0aUK10/LXQhejudDCqIJ0W1Pr0EOadV
	 kmcTwwUyXLOTg==
Date: Sat, 20 Jul 2024 11:48:44 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Michael Hennerich
 <michael.hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Jonathan Corbet <corbet@lwn.net>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>,
 Ramona Gradinariu <ramona.gradinariu@analog.com>
Subject: Re: [PATCH v4 0/3] iio: adc: ad4695: new driver for AD4695 and
 similar ADCs
Message-ID: <20240720114844.6588cb39@jic23-huawei>
In-Reply-To: <20240711-iio-adc-ad4695-v4-0-c31621113b57@baylibre.com>
References: <20240711-iio-adc-ad4695-v4-0-c31621113b57@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 11 Jul 2024 14:15:40 -0500
David Lechner <dlechner@baylibre.com> wrote:

> This is adding DT bindings and a new driver for the AD4695 and similar
> devices. The plan is to implement quite a few more features, but this
> is a complex chip so we're spreading out the work. To start with, we
> have a reasonably complete DT binding and a very basic driver.
> 
> This work is being done in collaboration with Analog Devices Inc.,
> hence they listed as maintainers rather than me. The code has been
> tested on a ZedBoard with an EVAL-AD4696FMCZ using the internal LDO,
> an external reference and a variety of input channel configurations.
Series applied to the testing branch of iio.git which I'll rebase on
rc1 once available and push out as the normal togreg branch for
linux-next to pick up.


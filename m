Return-Path: <linux-kernel+bounces-366394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 43AF599F4BA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 20:02:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2779B20D7E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 18:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B4E227BB2;
	Tue, 15 Oct 2024 18:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ONKR8oEy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7592F229114;
	Tue, 15 Oct 2024 18:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729015244; cv=none; b=dvcwwtIoTc4keis9zVmjAKk4lKUGB6UWFpu+Z8K1Ih6HNrbfs/VA1c+IEu0u/IlWMe4ZL2qoCtrkIZT1KHRZ83o/FOxZX0gf75rnyPOws+WF6YgTG07E2Digh+M8z9NFt6fsEV8NVrfQPWDenKPQnQiNt14OlbjQAef7mobni0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729015244; c=relaxed/simple;
	bh=6BAMH+Px+76REEHH++B/Lc+QYvBL3VcxAy72V4ZN4Lk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s1nYVbpwBKKIOPyil3u1m+pV5fGnciaPDFLQkmkyCL58h/UFT8x4uLfvkQqKH9k7NpW+lj7Z5rJU5CTjKJuniFgJ8YgVCKAlMKCjJ6oMfq7zNiqjseKzDxjzU10hkD+bXuacQ67cspDN1Ul8+IGBlPoQKK+Iz4tL7pNRPe8n1yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ONKR8oEy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7CD9C4CEC7;
	Tue, 15 Oct 2024 18:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729015244;
	bh=6BAMH+Px+76REEHH++B/Lc+QYvBL3VcxAy72V4ZN4Lk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ONKR8oEyIWD64bnr9k3vrIb8fy7uiel4qC7K0XlOVM2F1vE1DzYnwgz1xgZEtJ219
	 WPGyXHqtA2XLYzCl8ZumyRpEtAwVTAAmYpjcc3UI8kYek/q0PatGJywMgYafAcieLj
	 oBrESgZz/Fa8ovD6jTp2oUfsTJIlHWt6D2nipWCB8pJSO/iw3O1j/kKUhw+HsTExYA
	 qlSnSIHRwTd1381Ku77bxi9HOtFGHMQ/NgA89I68LXZkgnG2pee4szdCMQIq16557J
	 nw3NwYCsHtdzjR18kfT2/ZGSmSjNqou2Fe3PaJ8xOxaP8u2ZO7B64CmhGuuGx9BwzX
	 f+FuegrTqKiJg==
Date: Tue, 15 Oct 2024 19:00:34 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Trevor Gamblin <tgamblin@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, David
 Lechner <dlechner@baylibre.com>, Uwe Kleine-Konig
 <u.kleine-koenig@baylibre.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH v5 3/3] docs: iio: new docs for ad7625 driver
Message-ID: <20241015190034.3a6f6761@jic23-huawei>
In-Reply-To: <20240909-ad7625_r1-v5-3-60a397768b25@baylibre.com>
References: <20240909-ad7625_r1-v5-0-60a397768b25@baylibre.com>
	<20240909-ad7625_r1-v5-3-60a397768b25@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 09 Sep 2024 10:30:49 -0400
Trevor Gamblin <tgamblin@baylibre.com> wrote:

> Add documentation for the AD7625/AD7626/AD7960/AD7961 ADCs.
> 
> Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
Bot picked up that this wasn't added to index.rst. I fixed up.

Thanks,

Jonathan


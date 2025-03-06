Return-Path: <linux-kernel+bounces-549276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72FD1A55037
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 17:08:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97C6E3A8AE0
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 16:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0741211A3C;
	Thu,  6 Mar 2025 16:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="WiFKufXs"
Received: from out.smtpout.orange.fr (out-17.smtpout.orange.fr [193.252.22.17])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6443F19B5B4
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 16:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741277305; cv=none; b=Pc984Ckw7mmO9Q6pbEUzocR4Zpt0rl3rGlA4wHX2TCC8iH/B8UzspXrP8VGaE/B/uJd3PAhSHMQZQVKPMdISlAEE/0ngZ0KNxH+FvdW3rbIl4OawGs+iDgj6Rj7LpX2DrfvgwmxS4tvcdJ2rXF74RYNozD8dS1Ru3UdwwWSSA+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741277305; c=relaxed/simple;
	bh=Pi3p6v85jCk2h58XRr0tIfb4nAr/BVfm4E1zLWaVWzQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=imz3CDMucqcvLDA4hrHpLUDyWuQEhNsZaRe7Is2QYx9C4o7frz8mUGUR0ujWkrAkqG8kBxHVpyqOFPiu3QeiGIy48GMP+xAy0Ydt5KUde9LmBqFtVnHQ0g+yTsqLFJpyplHNqnLa4AhIk4j+pnLDERx5SG6siP0eISkTeNP3hfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=WiFKufXs; arc=none smtp.client-ip=193.252.22.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id qDlStMikP0ogTqDlftO2fs; Thu, 06 Mar 2025 17:08:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1741277300;
	bh=uGTIrVl9lBU8APAWKpcHUHguIxwD0cUIqzO9NpuCA9I=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=WiFKufXslWpe8Su6MzkgZj/f0j05oabHMLX4jrXOmX36bhPnZ02Wu+8QlXPhNvnFr
	 OYgBA1Z2f00apfEeoSqtVxS6cAYRKYhaLOh2A/ndwwooQY6WcY0IMjDI5U8W871PDn
	 ZWW+FhLixYxLN6zTaiSmDt0cKxio4xK1rLs2/xQqZvE8HDf1Z3FFbHhN6wJIGde7TF
	 7t+m2MqTQO1UVZbi9x0SmlvVIZ2zQVOaBiVQJwPsSU+P/bCAbl3jzfWB0RJb7+Widf
	 g0+TjI7zmxhK5gTN0Mnq+HrJ9xEKhF+lDhErVKkOAc4LbJ0Hw7iG62thiVtro+mpuF
	 pKeEIVkUIJ6aQ==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Thu, 06 Mar 2025 17:08:20 +0100
X-ME-IP: 124.33.176.97
Message-ID: <722e147b-fdd1-4098-8d60-48c83e36a7f7@wanadoo.fr>
Date: Fri, 7 Mar 2025 01:08:15 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 7/7] test_bits: add tests for BIT_U*()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Yury Norov <yury.norov@gmail.com>,
 Lucas De Marchi <lucas.demarchi@intel.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Tvrtko Ursulin
 <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Andrew Morton <akpm@linux-foundation.org>,
 linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Andi Shyti <andi.shyti@linux.intel.com>,
 David Laight <David.Laight@aculab.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
References: <20250306-fixed-type-genmasks-v5-0-b443e9dcba63@wanadoo.fr>
 <20250306-fixed-type-genmasks-v5-7-b443e9dcba63@wanadoo.fr>
 <Z8mfAQGUvm3z86kE@smile.fi.intel.com>
Content-Language: en-US
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Autocrypt: addr=mailhol.vincent@wanadoo.fr; keydata=
 xjMEZluomRYJKwYBBAHaRw8BAQdAf+/PnQvy9LCWNSJLbhc+AOUsR2cNVonvxhDk/KcW7FvN
 LFZpbmNlbnQgTWFpbGhvbCA8bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI+wrIEExYKAFoC
 GwMFCQp/CJcFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AWIQTtj3AFdOZ/IOV06OKrX+uI
 bbuZwgUCZx41XhgYaGtwczovL2tleXMub3BlbnBncC5vcmcACgkQq1/riG27mcIYiwEAkgKK
 BJ+ANKwhTAAvL1XeApQ+2NNNEwFWzipVAGvTRigA+wUeyB3UQwZrwb7jsQuBXxhk3lL45HF5
 8+y4bQCUCqYGzjgEZx4y8xIKKwYBBAGXVQEFAQEHQJrbYZzu0JG5w8gxE6EtQe6LmxKMqP6E
 yR33sA+BR9pLAwEIB8J+BBgWCgAmFiEE7Y9wBXTmfyDldOjiq1/riG27mcIFAmceMvMCGwwF
 CQPCZwAACgkQq1/riG27mcJU7QEA+LmpFhfQ1aij/L8VzsZwr/S44HCzcz5+jkxnVVQ5LZ4B
 ANOCpYEY+CYrld5XZvM8h2EntNnzxHHuhjfDOQ3MAkEK
In-Reply-To: <Z8mfAQGUvm3z86kE@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 06/03/2025 at 22:11, Andy Shevchenko wrote:
> On Thu, Mar 06, 2025 at 08:29:58PM +0900, Vincent Mailhol via B4 Relay wrote:
>> From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
>>
>> Add some additional tests in lib/test_bits.c to cover the expected
>> results of the fixed type BIT_U*() macros.
> 
> Still would be good to have a small assembly test case for GENMASK*() as they
> went split and it will be a good regression test in case somebody decides to
> unify both without much thinking..

Let me confirm that I correctly understood your ask. Would something
like this meet your expectations?

diff --git a/lib/test_bits.c b/lib/test_bits.c
index 72984fae7b81..869b291587e6 100644
--- a/lib/test_bits.c
+++ b/lib/test_bits.c
@@ -136,6 +136,29 @@ static void genmask_input_check_test(struct kunit
*test)
 	KUNIT_EXPECT_EQ(test, 0, GENMASK_INPUT_CHECK(127, 0));
 }

+#undef __LINUX_BITS_H
+#undef GENMASK
+#undef GENMASK_ULL
+#define __ASSEMBLY__
+#include <linux/bits.h>
+static void asm_genmask_test(struct kunit *test)
+{
+	KUNIT_EXPECT_EQ(test, 1ul, GENMASK(0, 0));
+	KUNIT_EXPECT_EQ(test, 3ul, GENMASK(1, 0));
+	KUNIT_EXPECT_EQ(test, 6ul, GENMASK(2, 1));
+	KUNIT_EXPECT_EQ(test, 0xFFFFFFFFul, GENMASK(31, 0));
+}
+
+static void asm_genmask_ull_test(struct kunit *test)
+{
+	KUNIT_EXPECT_EQ(test, 1ull, GENMASK_ULL(0, 0));
+	KUNIT_EXPECT_EQ(test, 3ull, GENMASK_ULL(1, 0));
+	KUNIT_EXPECT_EQ(test, 0x000000ffffe00000ull, GENMASK_ULL(39, 21));
+	KUNIT_EXPECT_EQ(test, 0xffffffffffffffffull, GENMASK_ULL(63, 0));
+}
+#undef __ASSEMBLY__
+#undef GENMASK
+#undef GENMASK_ULL

 static struct kunit_case bits_test_cases[] = {
        KUNIT_CASE(__genmask_test),
@@ -144,6 +167,8 @@ static struct kunit_case bits_test_cases[] = {
 	KUNIT_CASE(genmask_ull_test),
 	KUNIT_CASE(genmask_u128_test),
 	KUNIT_CASE(genmask_input_check_test),
+	KUNIT_CASE(asm_genmask_test),
+	KUNIT_CASE(asm_genmask_ull_test),
 	{}
 };


Yours sincerely,
Vincent Mailhol


